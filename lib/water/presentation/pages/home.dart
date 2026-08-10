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

import 'package:flutter/material.dart';
import '../../infrastructure/services/local_storage.dart';
import '../../infrastructure/services/water_meter_service.dart';
import '../../models/meter_reading.dart';
import '../components/consumption_chart.dart';
import '../components/recent_readings.dart';
import 'checkin.dart';
import 'first_time_setup.dart';  // We'll create this new screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WaterMeterService _service = WaterMeterService();
  List<MeterReading> _readings = [];
  bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser();
  }

  Future<void> _checkFirstTimeUser() async {
    final readings = await _service.getReadings();
    setState(() {
      _readings = readings;
      _isFirstTime = readings.isEmpty;
    });

    if (_isFirstTime) {
      // Delay to allow the screen to build before showing the dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFirstTimeDialog();
      });
    }
  }

  void _showFirstTimeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Welcome to Water Meter Reading'),
          content: Text('It looks like this is your first time using the water meter reading feature. Would you like to set it up now?'),
          actions: <Widget>[
            TextButton(
              child: Text('Later'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Set Up Now'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FirstTimeSetupScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = LocalStorage.getFirstName();
    final bool isLoggedIn = LocalStorage.getToken().isNotEmpty;

    if (_isFirstTime) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Water Meter Reader'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Water Meter Reading!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Start by setting up your first meter reading.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FirstTimeSetupScreen()),
                  );
                },
                child: Text('Set Up Now'),
              ),
            ],
          ),
        ),
      );
    }

    // Rest of the HomeScreen build method remains the same
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Meter Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToCheckIn(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadReadings,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLoggedIn
                      ? 'Hello, $firstName!'
                      : 'Welcome to Water Meter Reader',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 20),
                Text(
                  'Your Water Consumption',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                ConsumptionChart(readings: _readings),
                SizedBox(height: 20),
                Text(
                  'Recent Readings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                RecentReadings(readings: _readings),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCheckIn,
        child: Icon(Icons.add),
        tooltip: 'Add Reading',
      ),
    );
  }

  Future<void> _loadReadings() async {
    final readings = await _service.getReadings();
    setState(() {
      _readings = readings;
    });
  }

  void _navigateToCheckIn() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckInScreen()),
    );
    _loadReadings(); // Reload readings after returning from CheckInScreen
  }
}