import 'package:flutter/material.dart';

class CardItem<T> {
  final T id;
  final Widget widget;

  CardItem({required this.widget, required this.id});
}
