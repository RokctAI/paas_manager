import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_user_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class CreateUserNotifier extends StateNotifier<CreateUserState> {
  final UsersInterface _usersRepository;
  String _email = '';
  String _phone = '';
  String _lastname = '';
  String _firstname = '';

  CreateUserNotifier(this._usersRepository) : super(const CreateUserState());

  void setEmail(String value) {
    _email = value.trim();
  }

  void setPhone(String value) {
    _phone = value.trim();
  }

  void setLastname(String value) {
    _lastname = value.trim();
  }

  void setFirstname(String value) {
    _firstname = value.trim();
  }

  Future<void> createUser(BuildContext context,{
    Function(UserData?)? created,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _usersRepository.createUser(
      firstname: _firstname,
      lastname: _lastname,
      phone: _phone,
      email: _email,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        created?.call(data.data);
      },
      failure: (error,status) {
        debugPrint('====> create user fail $error');
        failed?.call();
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
            context,
            text: error,
            type: SnackBarType.error
        );
      },
    );
  }
}
