import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/create_campaign.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ScheduleCampaignDialog extends StatefulWidget {
  const ScheduleCampaignDialog({super.key});

  @override
  State<ScheduleCampaignDialog> createState() => _ScheduleCampaignDialogState();
}

class _ScheduleCampaignDialogState extends State<ScheduleCampaignDialog> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCampaignBloc(),
      child: BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
        builder: (context, state) {
          return AppResponsiveDialog(
            icon: BetterIcons.clock01Filled,
            title: context.tr.scheduleAnnouncement,
            subtitle: context.tr.scheduleAnnouncementLater,
            onClosePressed: () => Navigator.of(context).pop(),
            primaryButton: AppFilledButton(
              onPressed: () {
                context.read<CreateCampaignBloc>().onSubmit(
                  sendAt: _selectedDate,
                );

                Navigator.of(context).pop();
              },
              text: context.tr.schedule,
            ),
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
