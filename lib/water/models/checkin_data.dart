import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../infrastructure/services/local_storage.dart';
import '../infrastructure/services/water_meter_service.dart';
import 'check_in_step.dart';

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
    final currentStep = _getCurrentStep();
    if (currentStep == null) {
      // All steps completed
      await _submitCheckInData();
      Navigator.pop(context);
      return;
    }

    if (_isValidCodeForStep(code, currentStep)) {
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
    // Implement your logic to validate the QR code for each step
    // This might involve checking against a predefined set of codes
    return true;  // Placeholder
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
      // Implement photo capture and analysis here
      // For now, we'll just ask if the fridge is stocked
      bool isStocked = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Is the fridge fully stocked?'),
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

      await _saveCheckInData(CheckInStep.checkFridge, additionalInfo: isStocked ? 'Fridge stocked' : 'Fridge needs restocking');
    }
  }

  Future<void> _handleTurnOnComputer() async {
    if (!isCheckout) {
      // Implement QR code scanning for pin here
      // For now, we'll just ask for confirmation
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm computer is on'),
          content: Text('Please confirm that you have turned on the computer.'),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      await _saveCheckInData(CheckInStep.turnOnComputer);
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

      await _saveCheckInData(CheckInStep.turnOnComputer, additionalInfo: 'Turned off');
    }
  }

  Future<void> _handleTurnOnPrinter() async {
    await _saveCheckInData(CheckInStep.turnOnPrinter);
  }

  Future<void> _saveCheckInData(CheckInStep step, {String? additionalInfo}) async {
    final userId = LocalStorage.getUser()?.id;
    final checkInData = CheckInData(
      userId: userId,
      timestamp: DateTime.now(),
      step: step,
      isCheckin: !isCheckout,
      additionalInfo: additionalInfo,
    );

    await _service.saveCheckInData(checkInData);
  }

  Future<void> _submitCheckInData() async {
    // Implement API submission here
    print('Submitting check-in data to API');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}