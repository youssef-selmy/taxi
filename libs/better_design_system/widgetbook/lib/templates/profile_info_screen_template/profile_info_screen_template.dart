import 'package:api_response/api_response.dart';
import 'package:better_design_system/templates/profile_info_screen_template/profile_info_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppProfileInfoScreenTemplate)
Widget defaultProfileInfoScreenTemplate(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppProfileInfoScreenTemplate(
        profileResponse: ApiResponse.loaded(
          ProfileEntity(
            firstName: "John",
            lastName: "Doe",
            email: "john@mail.com",
            mobileNumber: "123456789",
            avatarUrl: ImageFaker().person.random(),
          ),
        ),
        onFirstNameChanged: (_) {},
        onLastNameChanged: (_) {},
        onEmailChanged: (_) {},
        onDeleteAccountPressed: () {},
        onUpload: (value, bytes) async {
          return ApiResponse.loaded(ImageFaker().person.random());
        },
      ),
    ],
  );
}
