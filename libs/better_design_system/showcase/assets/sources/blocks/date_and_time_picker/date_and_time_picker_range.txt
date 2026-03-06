import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/material.dart';

class DateAndTimePickerRange extends StatelessWidget {
  const DateAndTimePickerRange({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppDateRangePickerField(
              isFilled: false,
              onChanged: (value) {},
              label: 'Select Start & End Date',
            ),
          ],
        ),
      ),
    );
  }
}
