import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class FintechMajorExpensesCard extends StatelessWidget {
  const FintechMajorExpensesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Major Expenses', style: context.textTheme.titleSmall),
              SizedBox(
                width: 93,
                child: AppDropdownField.single(
                  items: [
                    AppDropdownItem(value: 'Weekly', title: 'Weekly'),
                    AppDropdownItem(value: 'Monthly', title: 'Monthly'),
                    AppDropdownItem(value: 'Yearly', title: 'Yearly'),
                  ],
                  type: DropdownFieldType.compact,
                  initialValue: 'Weekly',
                ),
              ),
            ],
          ),

          AppDivider(height: 35),

          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Housing', style: context.textTheme.labelLarge),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.warning,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      height: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Utilities',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colors.info,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              ),
                            ),
                            height: 18,
                          ),
                        ),

                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Food', style: context.textTheme.labelLarge),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colors.error,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              ),
                            ),
                            height: 18,
                          ),
                        ),

                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Others', style: context.textTheme.labelLarge),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colors.insight,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              ),
                            ),
                            height: 18,
                          ),
                        ),

                        Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                        Text(
                          '2K',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                        Text(
                          '4K',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                        Text(
                          '6K',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                        Text(
                          '8K',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                        Text(
                          '10K',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
