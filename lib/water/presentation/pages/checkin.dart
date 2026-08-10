// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../../app_constants.dart';
import '../../infrastructure/services/water_meter_service.dart';
import '../../infrastructure/services/local_storage.dart';
import '../../models/checkin_data.dart';
import '../../models/check_in_step.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final WaterMeterService _service = WaterMeterService();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedCode;
  List<CheckInStep> completedSteps = [];
  bool isCheckout = false;

  @override
  void initState() {
    super.initState();
    _determineCheckInOrCheckOut();
  }

  void _determineCheckInOrCheckOut() {
    final now = DateTime.now();
    if (now.hour >= 19 && now.hour < 20) {
      setState(() {
        isCheckout = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCheckout ? 'Check Out' : 'Check In'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan the QR code for ${_getCurrentStep()}'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedCode = scanData.code;
      });
      _processScannedCode(scannedCode!);
    });
  }

  void _processScannedCode(String code) async {
    final stepCode = _extractStepCodeFromUrl(code);
    if (stepCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid QR code')),
      );
      return;
    }

    final currentStep = _getCurrentStep();
    if (currentStep == null) {
      // All steps completed
      await _submitCheckInData();
      Navigator.pop(context);
      return;
    }

    if (_isValidCodeForStep(stepCode, currentStep)) {
      await _handleStep(currentStep);
      setState(() {
        completedSteps.add(currentStep);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid QR code for this step')),
      );
    }
  }

  String? _extractStepCodeFromUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) return null;
    
    String? stepCode = uri.queryParameters['\$stepCode'];
    return stepCode;
  }

  CheckInStep? _getCurrentStep() {
    final steps = isCheckout
        ? [
            CheckInStep.turnOnPrinter,
            CheckInStep.turnOnComputer,
            CheckInStep.openTank,
          ]
        : CheckInStep.values;

    for (var step in steps) {
      if (!completedSteps.contains(step)) {
        return step;
      }
    }
    return null;
  }

  bool _isValidCodeForStep(String code, CheckInStep step) {
    String? expectedCode = AppConstants.STEP_CODES[step.toString().split('.').last];
    return expectedCode == code;
  }

  Future<void> _handleStep(CheckInStep step) async {
    switch (step) {
      case CheckInStep.openTank:
        await _handleOpenTank();
        break;
      case CheckInStep.refillDispenser:
        await _handleRefillDispenser();
        break;
      case CheckInStep.clean:
        await _handleClean();
        break;
      case CheckInStep.checkFridge:
        await _handleCheckFridge();
        break;
      case CheckInStep.turnOnComputer:
        await _handleTurnOnComputer();
        break;
      case CheckInStep.turnOnPrinter:
        await _handleTurnOnPrinter();
        break;
    }
  }

  Future<void> _handleOpenTank() async {
    if (!isCheckout) {
      bool isTankFull = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Is the tank full?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );

      await _saveCheckInData(CheckInStep.openTank, additionalInfo: isTankFull ? 'Tank full' : 'Tank not full');
    } else {
      await _saveCheckInData(CheckInStep.openTank, additionalInfo: 'Closed tank');
    }
  }

  Future<void> _handleRefillDispenser() async {
    await _saveCheckInData(CheckInStep.refillDispenser);
  }

  Future<void> _handleClean() async {
    if (!isCheckout) {
      String cleanType = await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('What type of cleaning?'),
          children: [
            SimpleDialogOption(
              child: Text('Deep clean'),
              onPressed: () => Navigator.pop(context, 'Deep clean'),
            ),
            SimpleDialogOption(
              child: Text('Mop'),
              onPressed: () => Navigator.pop(context, 'Mop'),
            ),
            SimpleDialogOption(
              child: Text('Sweep'),
              onPressed: () => Navigator.pop(context, 'Sweep'),
            ),
          ],
        ),
      );

      await _saveCheckInData(CheckInStep.clean, additionalInfo: cleanType);
    }
  }

  Future<void> _handleCheckFridge() async {
    if (!isCheckout) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        bool isFridgeFull = await _analyzeImage(File(image.path));
        String additionalInfo = isFridgeFull ? 'Fridge is full' : 'Fridge needs restocking';

        await _saveCheckInData(CheckInStep.checkFridge,
            additionalInfo: additionalInfo,
            imagePath: image.path
        );

        if (!isFridgeFull) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Recommendation: Restock the fridge')),
          );
        }
      }
    }
  }

  Future<bool> _analyzeImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    bool isFull = labels.any((label) =>
    label.label.toLowerCase().contains('full') ||
        label.label.toLowerCase().contains('packed') ||
        label.confidence > 0.8
    );

    await imageLabeler.close();
    return isFull;
  }

  Future<void> _handleTurnOnComputer() async {
    if (!isCheckout) {
      String? pin = await _scanQRCodeForPin();
      if (pin != null) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Enter Computer PIN'),
            content: Text('PIN from scanned QR code: $pin'),
            actions: [
              TextButton(
                child: Text('Confirm'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        await _saveCheckInData(CheckInStep.turnOnComputer, additionalInfo: 'Computer turned on');
      }
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm computer is off'),
          content: Text('Please confirm that you have turned off the computer.'),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      await _saveCheckInData(CheckInStep.turnOnComputer, additionalInfo: 'Computer turned off');
    }
  }

  Future<String?> _scanQRCodeForPin() async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan QR Code for PIN'),
          content: Container(
            width: 300,
            height: 300,
            child: QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: (QRViewController controller) {
                controller.scannedDataStream.listen((scanData) {
                  controller.dispose();
                  Navigator.of(context).pop(scanData.code);
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleTurnOnPrinter() async {
    await _saveCheckInData(CheckInStep.turnOnPrinter);
  }

  Future<void> _saveCheckInData(CheckInStep step, {String? additionalInfo, String? imagePath}) async {
    final userId = LocalStorage.getUserId();
    final checkInData = CheckInData(
      userId: userId,
      timestamp: DateTime.now(),
      step: step,
      isCheckin: !isCheckout,
      additionalInfo: additionalInfo,
      imagePath: imagePath,
    );

    await _service.saveCheckInData(checkInData);
  }

  Future<void> _submitCheckInData() async {
    print('Submitting check-in data to API');
    // In a real scenario, you'd use your API service to send the data
    // await _service.submitCheckInData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}