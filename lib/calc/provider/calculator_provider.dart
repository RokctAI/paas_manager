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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/calculator_state.dart';

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(const CalculatorState());

  void addDigit(String digit) {
    if (state.display == '0' || state.display == 'Error') {
      state = state.copyWith(display: digit);
    } else {
      state = state.copyWith(display: state.display + digit);
    }
  }

  void clear() {
    state = const CalculatorState();
  }

  void setOperation(String operation) {
    try {
      double currentValue = double.parse(state.display);
      state = state.copyWith(
        previousValue: currentValue,
        currentOperation: operation,
        display: '0',
      );
    } catch (e) {
      state = state.copyWith(display: 'Error');
    }
  }

  void calculateResult() {
    try {
      double currentValue = double.parse(state.display);
      double? result;

      switch (state.currentOperation) {
        case '+':
          result = state.previousValue! + currentValue;
          break;
        case '-':
          result = state.previousValue! - currentValue;
          break;
        case '×':
          result = state.previousValue! * currentValue;
          break;
        case '÷':
          if (currentValue == 0) {
            throw Exception('Division by zero');
          }
          result = state.previousValue! / currentValue;
          break;
      }

      state = state.copyWith(
        display: result.toString(),
        currentOperation: '',
        previousValue: null,
      );
    } catch (e) {
      state = state.copyWith(display: 'Error');
    }
  }
}

final calculatorProvider =
StateNotifierProvider<CalculatorNotifier, CalculatorState>(
        (ref) => CalculatorNotifier());