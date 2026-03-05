import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_detail_items_and_categories.state.dart';
part 'shop_detail_items_and_categories.cubit.freezed.dart';

class ShopDetailItemsAndCategoriesBloc
    extends Cubit<ShopDetailItemsAndCategoriesState> {
  ShopDetailItemsAndCategoriesBloc()
    : super(ShopDetailItemsAndCategoriesState.initial());

  void onStarted() {}

  void onTabSelected(int index) {
    emit(state.copyWith(selectedTab: index));
    state.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int value) {
    emit(state.copyWith(selectedTab: value));
  }
}
