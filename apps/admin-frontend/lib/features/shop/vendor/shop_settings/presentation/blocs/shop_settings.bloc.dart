import 'package:admin_frontend/core/graphql/fragments/shop_document.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_document.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/data/graphql/shop_settings.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/data/repositories/shop_settings_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_settings.state.dart';
part 'shop_settings.bloc.freezed.dart';

class ShopSettingsBloc extends Cubit<ShopSettingsState> {
  final ShopSettingsRepository _shopSettingsRepository =
      locator<ShopSettingsRepository>();

  ShopSettingsBloc() : super(ShopSettingsState());

  void onStarted() {
    _fetchShopDocuments();
  }

  // Shop Document

  Future<void> _fetchShopDocuments() async {
    emit(state.copyWith(shopDocumentsState: const ApiResponse.loading()));

    var shopDocumentsOrError = await _shopSettingsRepository.getShopDocuments();

    emit(
      state.copyWith(
        shopDocuments: shopDocumentsOrError.data!.shopDocuments,
        shopDocumentsState: shopDocumentsOrError,
      ),
    );
  }

  void addDocument() {
    emit(
      state.copyWith(
        shopDocuments: [
          ...state.shopDocuments,
          Fragment$shopDocument(
            id: "",
            hasExpiryDate: false,
            isEnabled: true,
            isRequired: true,
            notificationDaysBeforeExpiry: 0,
            title: "",
            retentionPolicies: [
              Fragment$shopDocumentRetentionPolicy(
                id: "",
                deleteAfterDays: 0,
                title: "",
              ),
            ],
          ),
        ],
      ),
    );
  }

  void removeDocument(int documentIndex) {
    emit(
      state.copyWith(
        shopDocumentDeleteIds: [
          ...state.shopDocumentDeleteIds,
          state.shopDocuments[documentIndex].id,
        ],
        shopDocuments: state.shopDocuments
            .whereIndexed((index, e) => index != documentIndex)
            .toList(),
      ),
    );
  }

  void onDocumentTitleChange(int index, String title) {
    emit(
      state.copyWith(
        shopDocuments: state.shopDocuments.mapIndexed((secondIndex, document) {
          return secondIndex == index
              ? document.copyWith(title: title)
              : document;
        }).toList(),
      ),
    );
  }

  void onIsEnabledChange(int index, bool isEnabled) {
    emit(
      state.copyWith(
        shopDocuments: state.shopDocuments.mapIndexed((secondIndex, document) {
          return secondIndex == index
              ? document.copyWith(isEnabled: isEnabled)
              : document;
        }).toList(),
      ),
    );
  }

  void onNotificationDaysBeforeExpiryChange(
    int index,
    int notificationDaysBeforeExpiry,
  ) {
    final documents = state.shopDocuments;
    emit(
      state.copyWith(
        shopDocuments: documents.mapIndexed((int secondIndex, document) {
          if (index == secondIndex) {
            return document.copyWith(
              notificationDaysBeforeExpiry: notificationDaysBeforeExpiry,
            );
          }
          return document;
        }).toList(),
      ),
    );
  }

  void onNeedExpirationDateChange(int index, bool needExpirationDate) {
    final documents = state.shopDocuments;
    emit(
      state.copyWith(
        shopDocuments: documents.mapIndexed((secondIndex, document) {
          if (index == secondIndex) {
            return document.copyWith(hasExpiryDate: needExpirationDate);
          }
          return document;
        }).toList(),
      ),
    );
  }

  void onIsRequiredChange(int index, bool isRequired) {
    final documents = state.shopDocuments;
    emit(
      state.copyWith(
        shopDocuments: documents.mapIndexed((secondIndex, document) {
          if (index == secondIndex) {
            return document.copyWith(isRequired: isRequired);
          }
          return document;
        }).toList(),
      ),
    );
  }

  void addDocumentRetentionPolicy(int index) {
    emit(
      state.copyWith(
        shopDocuments: state.shopDocuments.mapIndexed((secondIndex, document) {
          return document.copyWith(
            retentionPolicies: [
              ...document.retentionPolicies,
              if (index == secondIndex)
                Fragment$shopDocumentRetentionPolicy(
                  id: "",
                  deleteAfterDays: 0,
                  title: "",
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void removeDocumentRetentionPolicy(
    int documentIndex,
    int retentionPolicyIndex,
  ) {
    emit(
      state.copyWith(
        shopDocumentRetentionPolicyDeleteIds: [
          ...state.shopDocumentRetentionPolicyDeleteIds,
          if (state
                  .shopDocuments[documentIndex]
                  .retentionPolicies[retentionPolicyIndex]
                  .id !=
              '')
            state
                .shopDocuments[documentIndex]
                .retentionPolicies[retentionPolicyIndex]
                .id,
        ],
        shopDocuments: state.shopDocuments.mapIndexed((index, shopDocument) {
          if (index == documentIndex) {
            return shopDocument.copyWith(
              retentionPolicies: shopDocument.retentionPolicies
                  .whereIndexed(
                    (retIndex, retention) => retIndex != retentionPolicyIndex,
                  )
                  .toList(),
            );
          } else {
            return shopDocument;
          }
        }).toList(),
      ),
    );
  }

  void onRetentionPolicyDeleteAfterChange(
    int index,
    int retentionIndex,
    int deleteAfter,
  ) {
    final retentionPolicy = state.shopDocuments[index].retentionPolicies;
    emit(
      state.copyWith(
        shopDocuments: state.shopDocuments.mapIndexed((secondIndex, document) {
          if (index == secondIndex) {
            return document.copyWith(
              retentionPolicies: retentionPolicy.mapIndexed((
                secondIndex,
                retention,
              ) {
                if (secondIndex == retentionIndex) {
                  return retention.copyWith(deleteAfterDays: deleteAfter);
                }
                return retention;
              }).toList(),
            );
          }
          return document;
        }).toList(),
      ),
    );
  }

  void onRetentionPolicyOptionChange(
    int documentIndex,
    int retentionPolicyIndex,
    String option,
  ) {
    final retentionPolicy =
        state.shopDocuments[documentIndex].retentionPolicies;
    emit(
      state.copyWith(
        shopDocuments: state.shopDocuments.mapIndexed((secondIndex, document) {
          if (documentIndex == secondIndex) {
            return document.copyWith(
              retentionPolicies: retentionPolicy.mapIndexed((
                secondIndex,
                retention,
              ) {
                if (secondIndex == retentionPolicyIndex) {
                  return retention.copyWith(title: option);
                }
                return retention;
              }).toList(),
            );
          }
          return document;
        }).toList(),
      ),
    );
  }

  void saveChanges() async {
    await _removeShopDocument();
    await _createShopDocument();
    await _updateShopDocument();
    await _removeShopDocumentRetentionPolicy();
    await _createShopDocumentRetentionPolicy();
    await _updateShopDocumentRetentionPolicy();
    onStarted();
  }

  Future<void> _removeShopDocument() async {
    if (state.shopDocumentDeleteIds.isNotEmpty) {
      await _shopSettingsRepository.deleteShopDocument(
        deleteShopDocumentInput: Input$DeleteManyShopDocumentsInput(
          filter: Input$ShopDocumentDeleteFilter(
            id: Input$IDFilterComparison($in: state.shopDocumentDeleteIds),
          ),
        ),
      );
    }
  }

  Future<void> _createShopDocument() async {
    var shopDocumentsToAdd = state.shopDocuments
        .where((e) => e.id == '')
        .toList();

    if (shopDocumentsToAdd.isNotEmpty) {
      final shopDocuments = await _shopSettingsRepository.createShopDocument(
        createShopDocumentInput: Input$CreateManyShopDocumentsInput(
          shopDocuments: shopDocumentsToAdd.map((e) => e.toInput()).toList(),
        ),
      );
      if (shopDocuments.data != null) {
        for (var i = 0; i < shopDocumentsToAdd.length; i++) {
          emit(
            state.copyWith(
              shopDocuments: state.shopDocuments.mapIndexed((index, doc) {
                if (doc == shopDocumentsToAdd[i]) {
                  return doc.copyWith(
                    id: shopDocuments.data!.createManyShopDocuments[i].id,
                  );
                } else {
                  return doc;
                }
              }).toList(),
            ),
          );
        }
      }
    }
  }

  Future<void> _updateShopDocument() async {
    final stableShopDocuments = state.shopDocumentsState.data!.shopDocuments;

    final shopDocuments = state.shopDocuments.where((e) => e.id != '').toList();

    stableShopDocuments.forEachIndexed((index, element) async {
      var shopDocument = shopDocuments.firstWhereOrNull(
        (e) => e.id == element.id,
      );
      if (shopDocument != null && element != shopDocument) {
        await _shopSettingsRepository.updateShopDocument(
          updateShopDocumentInput: Input$UpdateOneShopDocumentInput(
            id: shopDocument.id,
            update: shopDocument.toInput(),
          ),
        );
      }
    });
  }

  Future<void> _removeShopDocumentRetentionPolicy() async {
    if (state.shopDocumentRetentionPolicyDeleteIds.isNotEmpty) {
      await _shopSettingsRepository.deleteShopDocumentRetentionPolicy(
        deleteShopDocumentRetentionPolicyInput:
            Input$DeleteManyShopDocumentRetentionPoliciesInput(
              filter: Input$ShopDocumentRetentionPolicyDeleteFilter(
                id: Input$IDFilterComparison(
                  $in: state.shopDocumentRetentionPolicyDeleteIds,
                ),
              ),
            ),
      );
    }
  }

  Future<void> _createShopDocumentRetentionPolicy() async {
    for (final shopDocument in state.shopDocuments) {
      if (shopDocument.retentionPolicies.isEmpty) {
        continue;
      }
      if (shopDocument.id == '') {
        throw Exception('All shop documents must be saved prior to this step');
      }
      if (shopDocument.retentionPolicies.any((e) => e.id == '')) {
        await _shopSettingsRepository.createShopDocumentRetentionPolicy(
          createShopDocumentRetentionPolicyInput:
              Input$CreateManyShopDocumentRetentionPoliciesInput(
                shopDocumentRetentionPolicies: shopDocument.retentionPolicies
                    .where((e) => e.id == '')
                    .map((e) => e.toInput(shopDocument.id))
                    .toList(),
              ),
        );
      }
    }
  }

  Future<void> _updateShopDocumentRetentionPolicy() async {
    for (final shopDocument in state.shopDocuments) {
      final stableRetentionPolicies =
          state.shopDocumentsState.data?.shopDocuments
              .firstWhereOrNull((e) => e.id == shopDocument.id)
              ?.retentionPolicies
              .toList() ??
          [];
      final currentRetentionPolicies = shopDocument.retentionPolicies
          .where((policy) => policy.id != '')
          .toList();
      final retentionPoliciesToUpdate = stableRetentionPolicies
          .where(
            (stablePolicy) => currentRetentionPolicies.any(
              (policy) =>
                  policy.id == stablePolicy.id && policy != stablePolicy,
            ),
          )
          .toList();
      for (final retentionPolicy in retentionPoliciesToUpdate) {
        await _shopSettingsRepository.updateShopDocumentRetentionPolicy(
          updateShopDocumentRetentionPolicyInput:
              Input$UpdateOneShopDocumentRetentionPolicyInput(
                id: retentionPolicy.id,
                update: Input$ShopDocumentRetentionPolicyInput(
                  shopDocumentId: shopDocument.id,
                  deleteAfterDays: retentionPolicy.deleteAfterDays,
                  title: retentionPolicy.title,
                ),
              ),
        );
      }
    }
  }
}
