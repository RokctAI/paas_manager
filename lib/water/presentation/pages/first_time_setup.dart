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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:venderfoodyman/water/infrastructure/services/local_storage.dart';
import '../../../app_constants.dart';
import '../../infrastructure/services/water_meter_service.dart';
import '../../models/meter_reading.dart';
import '../../models/shop.dart';


class FirstTimeSetupScreen extends StatefulWidget {
  const FirstTimeSetupScreen({super.key});

  @override
  _FirstTimeSetupScreenState createState() => _FirstTimeSetupScreenState();
}

class _FirstTimeSetupScreenState extends State<FirstTimeSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _meterIdController = TextEditingController();
  final _readingController = TextEditingController();
  final _shopSearchController = TextEditingController();
  final WaterMeterService _service = WaterMeterService();
  List<Shop> _shops = [];
  Shop? _selectedShop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Time Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s set up your water meter reading',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _shopSearchController,
                decoration: const InputDecoration(
                  labelText: 'Search for your shop',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: _searchShops,
              ),
              const SizedBox(height: 10),
              if (_shops.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _shops.length,
                    itemBuilder: (context, index) {
                      final shop = _shops[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: shop.logoImg,
                          width: 50,
                          height: 50,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(shop.title),
                        onTap: () {
                          setState(() {
                            _selectedShop = shop;
                            _shopSearchController.text = shop.title;
                          });
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _meterIdController,
                decoration: const InputDecoration(
                  labelText: 'Meter ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Meter ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _readingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Current Meter Reading',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the current reading';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitFirstReading,
                child: const Text('Submit First Reading'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchShops(String query) async {
    if (query.length < 2) return;

    final url = Uri.parse('${AppConstants.baseUrl}/api/v1/rest/shops/paginate');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Shop> shops = (data['data'] as List)
          .map((shopJson) => Shop.fromJson(shopJson))
          .where((shop) => shop.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _shops = shops;
      });
    } else {
      // Handle error
      print('Failed to load shops');
    }
  }

  void _submitFirstReading() async {
    if (_formKey.currentState!.validate() && _selectedShop != null) {
      final meterId = _meterIdController.text;
      final reading = int.parse(_readingController.text);

      final newReading = MeterReading(
        meterId: meterId,
        reading: reading,
        timestamp: DateTime.now(),
        userId: LocalStorage.getUserId(),
        shopId: _selectedShop!.id,
      );

      await _service.saveReading(newReading);
      await LocalStorage.setSelectedShop(_selectedShop!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First reading submitted successfully!')),
      );

      Navigator.of(context).pop(); // Return to HomeScreen
    } else if (_selectedShop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a shop')),
      );
    }
  }

  @override
  void dispose() {
    _meterIdController.dispose();
    _readingController.dispose();
    _shopSearchController.dispose();
    super.dispose();
  }
}