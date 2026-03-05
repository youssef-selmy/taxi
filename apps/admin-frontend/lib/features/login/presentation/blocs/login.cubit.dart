import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.state.dart';
part 'login.cubit.freezed.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void reset() {
    emit(LoginState.initial());
  }
}
