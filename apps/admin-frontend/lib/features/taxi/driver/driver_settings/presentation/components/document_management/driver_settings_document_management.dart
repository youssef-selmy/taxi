import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_add_document.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_add_retention_policy.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_document_type.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_is_enabled.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_is_required.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_need_expiration_date.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_notification_days_before_expiry.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_retention_policy_delete_after.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management_retention_policy_title.dart';
import 'package:better_icons/better_icons.dart';

class DriverSettingsDocumentManagement extends StatelessWidget {
  const DriverSettingsDocumentManagement({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return Form(
      key: formKey,
      child: BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
        builder: (context, state) {
          return Theme(
            data: context.theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: const LargeHeader(title: 'Document Management Settings'),
              subtitle: const Column(
                children: [SizedBox(height: 16), Divider(height: 1)],
              ),
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1),
                    );
                  },
                  itemCount: state.driverDocuments.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return context.responsive(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.tr.documentType,
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          DriverSettingsDocumentManagementDocumentType(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          DriverSettingsDocumentManagementIsEnabled(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            context.tr.notificationDaysBeforeExpiry,
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          DriverSettingsDocumentManagementNotificationDaysBeforeExpiry(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          DriverSettingsDocumentManagementNeedExpirationDate(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          DriverSettingsDocumentManagementIsRequired(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, retentionPolicyIndex) {
                              return const SizedBox(height: 16);
                            },
                            itemCount: state
                                .driverDocuments[index]
                                .retentionPolicies
                                .length,
                            itemBuilder: (context, retentionPolicyIndex) {
                              var retentionPolicy = state
                                  .driverDocuments[index]
                                  .retentionPolicies[retentionPolicyIndex];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        context.tr.retentionPolicy,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      CupertinoButton(
                                        onPressed: () {
                                          bloc.removeDocumentRetentionPolicy(
                                            index,
                                            retentionPolicyIndex,
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              BetterIcons.cancel01Outline,
                                              color: context.colors.error,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              context.tr.delete,
                                              style: context
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: context.colors.error,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    context.tr.deleteAfter,
                                    style: context.textTheme.bodyMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 8),
                                  DriverSettingsDocumentManagementRetentionPolicyDeleteAfter(
                                    retentionPolicy: retentionPolicy,
                                    documentIndex: index,
                                    retentionPolicyIndex: retentionPolicyIndex,
                                  ),
                                  const SizedBox(height: 8),
                                  DriverSettingsDocumentManagementRetentionPolicyTitle(
                                    retentionPolicy: retentionPolicy,
                                    documentIndex: index,
                                    retentionPolicyIndex: retentionPolicyIndex,
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child:
                                    DriverSettingsDocumentManagementAddRetentionPolicy(
                                      index: index,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: AppOutlinedButton(
                                  onPressed: () {
                                    bloc.removeDocument(index);
                                  },
                                  text: context.tr.delete,
                                  color: SemanticColor.error,
                                  prefixIcon: BetterIcons.cancel01Outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      lg: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        bloc.removeDocument(index);
                                      },
                                      minimumSize: Size(0, 0),
                                      child: Icon(
                                        BetterIcons.cancel01Outline,
                                        size: 24,
                                        color: context.colors.error,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      context.tr.documentType,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child:
                                    DriverSettingsDocumentManagementDocumentType(
                                      index: index,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DriverSettingsDocumentManagementIsEnabled(
                            index: index,
                          ),
                          // const SizedBox(height: 16),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 2,
                          //       child: Text(
                          //         context.tr.numberOfImagesNeeded,
                          //         style: context.textTheme.bodyMedium,
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child:
                          //           DriverSettingsDocumentManagementNumbersOfImageNeed(
                          //             index: index,
                          //           ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  context.tr.notificationDaysBeforeExpiry,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                              Expanded(
                                child:
                                    DriverSettingsDocumentManagementNotificationDaysBeforeExpiry(
                                      index: index,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DriverSettingsDocumentManagementNeedExpirationDate(
                            index: index,
                          ),
                          const SizedBox(height: 16),
                          DriverSettingsDocumentManagementIsRequired(
                            index: index,
                          ),
                          const SizedBox(height: 16),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, retentionIndex) {
                              return const SizedBox(height: 8);
                            },
                            itemCount: state
                                .driverDocuments[index]
                                .retentionPolicies
                                .length,
                            itemBuilder: (context, retentionPolicyIndex) {
                              var retentionPolicy = state
                                  .driverDocuments[index]
                                  .retentionPolicies[retentionPolicyIndex];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      context.tr.retentionPolicy,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Text(
                                          context.tr.deleteAfter,
                                          style: context.textTheme.bodyMedium
                                              ?.variant(context),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child:
                                              DriverSettingsDocumentManagementRetentionPolicyDeleteAfter(
                                                retentionPolicy:
                                                    retentionPolicy,
                                                documentIndex: index,
                                                retentionPolicyIndex:
                                                    retentionPolicyIndex,
                                              ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child:
                                              DriverSettingsDocumentManagementRetentionPolicyTitle(
                                                retentionPolicy:
                                                    retentionPolicy,
                                                documentIndex: index,
                                                retentionPolicyIndex:
                                                    retentionPolicyIndex,
                                              ),
                                        ),
                                        const SizedBox(width: 8),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            bloc.removeDocumentRetentionPolicy(
                                              index,
                                              retentionPolicyIndex,
                                            );
                                          },
                                          minimumSize: Size(0, 0),
                                          child: Icon(
                                            BetterIcons.cancel01Outline,
                                            size: 20,
                                            color:
                                                context.colors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          DriverSettingsDocumentManagementAddRetentionPolicy(
                            index: index,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                context.responsive(
                  const Divider(height: 48),
                  lg: const SizedBox(height: 16),
                ),
                context.responsive(
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DriverSettingsDocumentManagementAddDocument(),
                      ),
                    ],
                  ),
                  lg: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [DriverSettingsDocumentManagementAddDocument()],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
