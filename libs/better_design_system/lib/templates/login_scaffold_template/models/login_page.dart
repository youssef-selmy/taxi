import 'package:flutter/material.dart';

class LoginScreen<T> {
  final Widget child;
  final T model;

  LoginScreen({required this.child, required this.model});
}
