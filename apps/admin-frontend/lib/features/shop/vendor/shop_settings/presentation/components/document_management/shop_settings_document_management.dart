import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_add_document.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_add_retention_policy.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_document_type.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_is_enabled.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_is_required.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_need_expiration_date.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_notification_days_before_expiry.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_retention_policy_delete_after.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management_retention_policy_title.dart';
import 'package:better_icons/better_icons.dart';

class ShopSettingsDocumentManagement extends StatelessWidget {
  const ShopSettingsDocumentManagement({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopSettingsBloc>();
    return Form(
      key: formKey,
      child: BlocBuilder<ShopSettingsBloc, ShopSettingsState>(
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
                  itemCount: state.shopDocuments.length,
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
                          ShopSettingsDocumentManagementDocumentType(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          ShopSettingsDocumentManagementIsEnabled(index: index),
                          const SizedBox(height: 32),
                          Text(
                            context.tr.notificationDaysBeforeExpiry,
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          ShopSettingsDocumentManagementNotificationDaysBeforeExpiry(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          ShopSettingsDocumentManagementNeedExpirationDate(
                            index: index,
                          ),
                          const SizedBox(height: 32),
                          ShopSettingsDocumentManagementIsRequired(
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
                                .shopDocuments[index]
                                .retentionPolicies
                                .length,
                            itemBuilder: (context, retentionPolicyIndex) {
                              var retentionPolicy = state
                                  .shopDocuments[index]
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
                                  ShopSettingsDocumentManagementRetentionPolicyDeleteAfter(
                                    retentionPolicy: retentionPolicy,
                                    documentIndex: index,
                                    retentionPolicyIndex: retentionPolicyIndex,
                                  ),
                                  const SizedBox(height: 8),
                                  ShopSettingsDocumentManagementRetentionPolicyTitle(
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
                                    ShopSettingsDocumentManagementAddRetentionPolicy(
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
                                    ShopSettingsDocumentManagementDocumentType(
                                      index: index,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ShopSettingsDocumentManagementIsEnabled(index: index),
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
                          //           ShopSettingsDocumentManagementNumbersOfImageNeed(
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
                                    ShopSettingsDocumentManagementNotificationDaysBeforeExpiry(
                                      index: index,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ShopSettingsDocumentManagementNeedExpirationDate(
                            index: index,
                          ),
                          const SizedBox(height: 16),
                          ShopSettingsDocumentManagementIsRequired(
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
                                .shopDocuments[index]
                                .retentionPolicies
                                .length,
                            itemBuilder: (context, retentionPolicyIndex) {
                              var retentionPolicy = state
                                  .shopDocuments[index]
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
                                              ShopSettingsDocumentManagementRetentionPolicyDeleteAfter(
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
                                              ShopSettingsDocumentManagementRetentionPolicyTitle(
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
                          ShopSettingsDocumentManagementAddRetentionPolicy(
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
                        child: ShopSettingsDocumentManagementAddDocument(),
                      ),
                    ],
                  ),
                  lg: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ShopSettingsDocumentManagementAddDocument()],
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
