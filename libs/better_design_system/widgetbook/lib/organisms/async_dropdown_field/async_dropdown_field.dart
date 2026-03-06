// ignore_for_file: depend_on_referenced_packages

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field_type.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/organisms/async_dropdown_field/async_dropdown_field.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Mock user model for examples
class _MockUser {
  final String id;
  final String name;
  final String email;

  const _MockUser({required this.id, required this.name, required this.email});
}

// Mock data
const _mockUsers = [
  _MockUser(id: '1', name: 'John Doe', email: 'john@example.com'),
  _MockUser(id: '2', name: 'Jane Smith', email: 'jane@example.com'),
  _MockUser(id: '3', name: 'Bob Johnson', email: 'bob@example.com'),
  _MockUser(id: '4', name: 'Alice Brown', email: 'alice@example.com'),
  _MockUser(id: '5', name: 'Charlie Wilson', email: 'charlie@example.com'),
  _MockUser(id: '6', name: 'Diana Ross', email: 'diana@example.com'),
  _MockUser(id: '7', name: 'Edward Miller', email: 'edward@example.com'),
  _MockUser(id: '8', name: 'Fiona Davis', email: 'fiona@example.com'),
];

List<AppDropdownItem<_MockUser>> _searchUsers(String query) {
  final lowerQuery = query.toLowerCase();
  return _mockUsers
      .where(
        (user) =>
            user.name.toLowerCase().contains(lowerQuery) ||
            user.email.toLowerCase().contains(lowerQuery),
      )
      .map(
        (user) => AppDropdownItem(
          title: user.name,
          value: user,
          subtitle: user.email,
          prefixIcon: BetterIcons.userCircle02Outline,
        ),
      )
      .toList();
}

List<AppDropdownItem<_MockUser>> _recentUsers = [
  AppDropdownItem(
    title: 'John Doe',
    value: _mockUsers[0],
    subtitle: 'john@example.com',
    prefixIcon: BetterIcons.userCircle02Outline,
  ),
  AppDropdownItem(
    title: 'Jane Smith',
    value: _mockUsers[1],
    subtitle: 'jane@example.com',
    prefixIcon: BetterIcons.userCircle02Outline,
  ),
];

@UseCase(name: 'Single Select', type: AppAsyncDropdownField)
Widget singleSelectAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppAsyncDropdownField<_MockUser>.single(
      label: 'Assign to',
      hint: 'Select user',
      searchHint: 'Search users...',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return ApiResponseLoaded(_searchUsers(query));
      },
      onChanged: (user) {
        debugPrint('Selected: ${user?.name}');
      },
    ),
  );
}

@UseCase(name: 'With Initial Items', type: AppAsyncDropdownField)
Widget withInitialItemsAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppAsyncDropdownField<_MockUser>.single(
      label: 'Assign to',
      hint: 'Select user',
      searchHint: 'Search users...',
      initialItems: _recentUsers,
      initialItemsHeader: 'Recent',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return ApiResponseLoaded(_searchUsers(query));
      },
      onChanged: (user) {
        debugPrint('Selected: ${user?.name}');
      },
    ),
  );
}

@UseCase(name: 'Multi Select with Chips', type: AppAsyncDropdownField)
Widget multiSelectAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppAsyncDropdownField<_MockUser>.multi(
      label: 'Team Members',
      hint: 'Select team members',
      searchHint: 'Search users...',
      showChips: true,
      initialItems: _recentUsers,
      initialItemsHeader: 'Recent',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return ApiResponseLoaded(_searchUsers(query));
      },
      onChanged: (users) {
        debugPrint('Selected: ${users?.map((u) => u.name).join(', ')}');
      },
    ),
  );
}

@UseCase(name: 'Error State', type: AppAsyncDropdownField)
Widget errorStateAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppAsyncDropdownField<_MockUser>.single(
      label: 'Assign to',
      hint: 'Select user',
      searchHint: 'Search users...',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return const ApiResponseError('Failed to fetch users');
      },
      onChanged: (user) {
        debugPrint('Selected: ${user?.name}');
      },
    ),
  );
}

@UseCase(name: 'Empty Results', type: AppAsyncDropdownField)
Widget emptyResultsAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppAsyncDropdownField<_MockUser>.single(
      label: 'Assign to',
      hint: 'Select user',
      searchHint: 'Search users...',
      emptyResultsText: 'No users found matching your search',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return const ApiResponseLoaded([]);
      },
      onChanged: (user) {
        debugPrint('Selected: ${user?.name}');
      },
    ),
  );
}

@UseCase(name: 'With Validation', type: AppAsyncDropdownField)
Widget withValidationAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: Form(
      child: AppAsyncDropdownField<_MockUser>.single(
        label: 'Assign to',
        hint: 'Select user',
        searchHint: 'Search users...',
        isRequired: true,
        initialItems: _recentUsers,
        initialItemsHeader: 'Recent',
        validator: (user) {
          if (user == null) {
            return 'Please select a user';
          }
          return null;
        },
        onSearch: (query) async {
          await Future.delayed(const Duration(milliseconds: 500));
          return ApiResponseLoaded(_searchUsers(query));
        },
        onChanged: (user) {
          debugPrint('Selected: ${user?.name}');
        },
      ),
    ),
  );
}

@UseCase(name: 'Compact Type', type: AppAsyncDropdownField)
Widget compactTypeAsyncDropdownField(BuildContext context) {
  return SizedBox(
    width: 300,
    child: AppAsyncDropdownField<_MockUser>.single(
      type: DropdownFieldType.compact,
      hint: 'Select user',
      searchHint: 'Search...',
      initialItems: _recentUsers,
      initialItemsHeader: 'Recent',
      onSearch: (query) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return ApiResponseLoaded(_searchUsers(query));
      },
      onChanged: (user) {
        debugPrint('Selected: ${user?.name}');
      },
    ),
  );
}
