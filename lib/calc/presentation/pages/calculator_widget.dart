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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/calculator_provider.dart';

class CalculatorWidget extends ConsumerWidget {
  const CalculatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                state.display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              _buildButton('7', ref),
              _buildButton('8', ref),
              _buildButton('9', ref),
              _buildButton('÷', ref, isOperation: true),
              _buildButton('4', ref),
              _buildButton('5', ref),
              _buildButton('6', ref),
              _buildButton('×', ref, isOperation: true),
              _buildButton('1', ref),
              _buildButton('2', ref),
              _buildButton('3', ref),
              _buildButton('-', ref, isOperation: true),
              _buildButton('C', ref, onPressed: () => ref.read(calculatorProvider.notifier).clear()),
              _buildButton('0', ref),
              _buildButton('=', ref, onPressed: () => ref.read(calculatorProvider.notifier).calculateResult()),
              _buildButton('+', ref, isOperation: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, WidgetRef ref, {bool isOperation = false, VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isOperation ? Colors.orange : Colors.grey[300],
        foregroundColor: isOperation ? Colors.white : Colors.black,
      ),
      onPressed: onPressed ?? () {
        if (isOperation) {
          ref.read(calculatorProvider.notifier).setOperation(label);
        } else {
          ref.read(calculatorProvider.notifier).addDigit(label);
        }
      },
      child: Text(label, style: const TextStyle(fontSize: 24)),
    );
  }
}