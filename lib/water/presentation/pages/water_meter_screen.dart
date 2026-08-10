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
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:venderfoodyman/water/infrastructure/services/local_storage.dart';
import '../../infrastructure/services/water_meter_service.dart';
import '../../models/meter_reading.dart';
import '../../models/store_info.dart';

class WaterMeterScreen extends StatefulWidget {
  const WaterMeterScreen({super.key});

  @override
  _WaterMeterScreenState createState() => _WaterMeterScreenState();
}

class _WaterMeterScreenState extends State<WaterMeterScreen> {
  final WaterMeterService _service = WaterMeterService();
  late Future<void> _initializeControllerFuture;
  List<MeterReading> readings = [];
  late CameraController _controller;
  bool _isCameraActive = true;
  StoreInfo? _storeInfo;
  bool _hasUnsentReadings = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
    _loadData();
    _loadStoreInfo();
    _scheduleDailyApiUpload();
    _checkUnsentReadings();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    return _controller.initialize();
  }

  Future<void> _loadData() async {
    final loadedReadings = await _service.getReadings();
    setState(() {
      readings = loadedReadings;
    });
  }

  Future<void> _loadStoreInfo() async {
    final storeInfo = await _service.getStoreInfo();
    setState(() {
      _storeInfo = storeInfo;
    });
    if (_storeInfo == null) {
      _showStoreInfoDialog();
    }
  }

  void _scheduleDailyApiUpload() {
    // This method will be called once a day to upload readings to the API
    Future.delayed(const Duration(days: 1), () {
      _uploadReadingsToApi();
      _scheduleDailyApiUpload(); // Schedule the next upload
    });
  }

  Future<void> _uploadReadingsToApi() async {
    final success = await _service.sendReadingsToApi();
    if (success) {
      print('Readings uploaded successfully');
    } else {
      print('Failed to upload readings');
    }
    await _checkUnsentReadings();
  }

  Future<void> _checkUnsentReadings() async {
    final unsentReadings = await _service.getUnsentReadings();
    setState(() {
      _hasUnsentReadings = unsentReadings.isNotEmpty;
    });
  }

  Future<void> _retryApiUpload() async {
    final success = await _service.sendReadingsToApi();
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Readings sent successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send readings. Please try again later.')),
      );
    }
    await _checkUnsentReadings();
  }

  Future<void> _showStoreInfoDialog() async {
    final result = await showDialog<StoreInfo>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String storeName = _storeInfo?.storeName ?? '';
        String branch = _storeInfo?.branch ?? '';
        return AlertDialog(
          title: Text(_storeInfo == null ? 'Enter Store Information' : 'Confirm Store Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Store Name'),
                onChanged: (value) => storeName = value,
                controller: TextEditingController(text: storeName),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Branch'),
                onChanged: (value) => branch = value,
                controller: TextEditingController(text: branch),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(StoreInfo(
                  storeName: storeName,
                  branch: branch,
                ));
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      await _service.saveStoreInfo(result);
      setState(() {
        _storeInfo = result;
      });
    }
  }

  void _toggleCamera(bool activate) {
    setState(() {
      _isCameraActive = activate;
    });
    if (activate) {
      _controller.resumePreview();
    } else {
      _controller.pausePreview();
    }
  }

  Future<void> _processImage(File imageFile) async {
    String? meterId = await _service.detectMeterId(imageFile);
    int? reading = await _service.detectReading(imageFile);

    if (meterId != null && reading != null) {
      bool? confirmed = await _showConfirmationDialog(meterId, reading);
      if (confirmed == true) {
        await _saveReading(meterId, reading, imageFile.path);
      }
    } else {
      await _showManualEntryDialog(imageFile.path);
    }
  }

  Future<bool?> _showConfirmationDialog(String meterId, int reading) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Reading'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meter ID: $meterId'),
            Text('Reading: $reading litres'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  Future<void> _showManualEntryDialog(String imagePath) async {
    String? meterId;
    String? readingStr;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Reading Manually'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Meter ID'),
              onChanged: (value) => meterId = value,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Meter Reading (8 digits)',
                hintText: 'e.g. 00123456',
              ),
              keyboardType: TextInputType.number,
              maxLength: 8,
              onChanged: (value) => readingStr = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              if (meterId != null && readingStr != null && readingStr!.length == 8) {
                int? reading = int.tryParse(readingStr!);
                if (reading != null) {
                  await _saveReading(meterId!, reading, imagePath);
                  Navigator.of(context).pop();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid 8-digit reading')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveReading(String meterId, int reading, String imagePath) async {
      final userId = LocalStorage.getUserId();
      final shop = await LocalStorage.getSelectedShop();

      if (shop == null) {
        throw Exception('No shop selected');
      }
      final newReading = MeterReading(
        meterId: meterId,
        reading: reading,
        timestamp: DateTime.now(),
        userId: userId,
        shopId: shop.id,
        imagePath: imagePath,
      );
      await LocalStorage.saveWaterMeterReading(newReading);
  }

  Future<void> _captureImage() async {
    if (_storeInfo == null) {
      await _showStoreInfoDialog();
      if (_storeInfo == null) return; // User cancelled store info entry
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Store Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Store Name: ${_storeInfo!.storeName}'),
            Text('Branch: ${_storeInfo!.branch}'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Edit'),
            onPressed: () {
              Navigator.of(context).pop(false);
              _showStoreInfoDialog();
            },
          ),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _initializeControllerFuture;
        final image = await _controller.takePicture();
        await _processImage(File(image.path));
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      await _processImage(File(image.path));
    }
  }

  void _showConsumptionHistory() {
    _toggleCamera(false);
    showDialog(
      context: context,
      builder: (context) {
        if (readings.isEmpty) {
          return AlertDialog(
            title: const Text('Consumption History'),
            content: const Text('No readings available.'),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _toggleCamera(true);
                },
              ),
            ],
          );
        }

        return AlertDialog(
          title: const Text('Consumption History'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: readings.length - 1,
              itemBuilder: (context, index) {
                final current = readings[index];
                final next = readings[index + 1];
                final consumptionLitres = next.reading - current.reading;
                return ListTile(
                  title: Text('Meter ID: ${current.meterId}'),
                  subtitle: Text(
                      'From: ${DateFormat('yyyy-MM-dd HH:mm').format(current.timestamp.toLocal())}\n'
                          'To: ${DateFormat('yyyy-MM-dd HH:mm').format(next.timestamp.toLocal())}\n'
                          'Consumption: $consumptionLitres litres'
                  ),
                  onTap: () => _showReadingDetails(current, next),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                _toggleCamera(true);
              },
            ),
            ElevatedButton(
              child: const Text('Show Reports'),
              onPressed: () {
                Navigator.of(context).pop();
                _showConsumptionReports();
              },
            ),
          ],
        );
      },
    );
  }

  void _showReadingDetails(MeterReading current, MeterReading next) {
    final consumptionLitres = next.reading - current.reading;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reading Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Meter ID: ${current.meterId}'),
              Text('From: ${DateFormat('yyyy-MM-dd HH:mm').format(current.timestamp.toLocal())}'),
              Text('Reading: ${current.reading} litres'),
              const SizedBox(height: 10),
              Text('To: ${DateFormat('yyyy-MM-dd HH:mm').format(next.timestamp.toLocal())}'),
              Text('Reading: ${next.reading} litres'),
              const SizedBox(height: 10),
              Text('Consumption: $consumptionLitres litres'),
              if (current.imagePath != null) ...[
                const SizedBox(height: 10),
                Image.file(File(current.imagePath!)),
              ],
              if (next.imagePath != null) ...[
                const SizedBox(height: 10),
                Image.file(File(next.imagePath!)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showConsumptionReports() {
    final now = DateTime.now();
    final weeklyConsumption = _calculateConsumption(now.subtract(Duration(days: now.weekday - 1)), now);
    final monthlyConsumption = _calculateConsumption(DateTime(now.year, now.month, 1), now);
    final yearlyConsumption = _calculateConsumption(DateTime(now.year, 1, 1), now);

    final highestDay = _findHighestConsumptionPeriod(const Duration(days: 1));
    final highestWeek = _findHighestConsumptionPeriod(const Duration(days: 7));
    final highestMonth = _findHighestConsumptionPeriod(const Duration(days: 30));

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: const Text('Consumption Reports'),
    content: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('This Week: $weeklyConsumption litres'),
    Text('This Month: $monthlyConsumption litres'),
    Text('This Year: $yearlyConsumption litres'),
    const SizedBox(height: 20),
    const Text('Highest Consumption:'),
    Text('Day: ${highestDay.consumption} litres on ${DateFormat('yyyy-MM-dd').format(highestDay.date)}'),
      Text('Week: ${highestWeek.consumption} litres (week of ${DateFormat('yyyy-MM-dd').format(highestWeek.date)})'),
      Text('Month: ${highestMonth.consumption} litres (${DateFormat('MMMM yyyy').format(highestMonth.date)})'),
    ],
    ),
    ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                _toggleCamera(true);
              },
            ),
          ],
        ),
    );
  }

  int _calculateConsumption(DateTime start, DateTime end) {
    int totalConsumption = 0;
    for (int i = 0; i < readings.length - 1; i++) {
      if (readings[i].timestamp.isAfter(start) && readings[i + 1].timestamp.isBefore(end)) {
        totalConsumption += readings[i + 1].reading - readings[i].reading;
      }
    }
    return totalConsumption;
  }

  ConsumptionPeriod _findHighestConsumptionPeriod(Duration period) {
    int highestConsumption = 0;
    DateTime highestDate = DateTime.now();

    for (int i = 0; i < readings.length - 1; i++) {
      final start = readings[i].timestamp;
      final end = start.add(period);
      final consumption = _calculateConsumption(start, end);
      if (consumption > highestConsumption) {
        highestConsumption = consumption;
        highestDate = start;
      }
    }

    return ConsumptionPeriod(date: highestDate, consumption: highestConsumption);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Meter Reader'),
        actions: [
          if (_hasUnsentReadings)
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: _retryApiUpload,
            ),
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: _showStoreInfoDialog,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showConsumptionHistory,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Today\'s Readings'),
                  content: const Text('Are you sure you want to clear all readings from today?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                      child: const Text('Clear'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await _service.clearTodayReadings();
                await _loadData();
                await _checkUnsentReadings();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isCameraActive
                ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
                : const Center(child: Text('Camera is off')),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isCameraActive ? _captureImage : null,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Capture'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ConsumptionPeriod {
  final DateTime date;
  final int consumption;

  ConsumptionPeriod({required this.date, required this.consumption});
}