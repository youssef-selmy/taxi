import 'package:admin_frontend/core/graphql/fragments/driver_document.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.extensions.dart';
import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/graphql/driver_settings.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/repositories/driver_settings_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_settings.state.dart';
part 'driver_settings.bloc.freezed.dart';

class DriverSettingsBloc extends Cubit<DriverSettingsState> {
  final DriverSettingsRepository _driverSettingsRepository =
      locator<DriverSettingsRepository>();

  DriverSettingsBloc() : super(DriverSettingsState());

  void onStarted() {
    _fetchDriverShiftRules();
    _fetchDriverDocuments();
  }

  // Driver Shift Rule

  Future<void> _fetchDriverShiftRules() async {
    emit(state.copyWith(driverShiftRulesState: const ApiResponse.loading()));

    var driverShiftRulesOrError = await _driverSettingsRepository
        .getDriverShiftRules();

    emit(
      state.copyWith(
        driverShiftRules: driverShiftRulesOrError.data!.driverShiftRules,
        driverShiftRulesState: driverShiftRulesOrError,
      ),
    );
  }

  void addRule() {
    emit(
      state.copyWith(
        driverShiftRules: [
          ...state.driverShiftRules,
          Fragment$driverShiftRule(
            id: "",
            maxHoursPerFrequency: 0,
            mandatoryBreakMinutes: 0,
            timeFrequency: Enum$TimeFrequency.Daily,
          ),
        ],
      ),
    );
  }

  void removeShiftRule(int index) {
    emit(
      state.copyWith(
        driverShiftDeleteIds: [
          ...state.driverShiftDeleteIds,
          if (state.driverShiftRules[index].id != "")
            state.driverShiftRules[index].id,
        ],
      ),
    );

    final driverShiftRules = state.driverShiftRules
        .whereIndexed((secondIndex, element) => index != secondIndex)
        .toList();

    emit(state.copyWith(driverShiftRules: driverShiftRules));
  }

  void onMaxHoursPerFrequencyChange(int index, int maxHoursPerFrequency) {
    emit(
      state.copyWith(
        driverShiftRules: state.driverShiftRules.mapIndexed((
          secondIndex,
          element,
        ) {
          if (index == secondIndex) {
            return element.copyWith(maxHoursPerFrequency: maxHoursPerFrequency);
          }
          return element;
        }).toList(),
      ),
    );
  }

  void onTimeFrequencyChange(int index, Enum$TimeFrequency? timeFrequency) {
    emit(
      state.copyWith(
        driverShiftRules: state.driverShiftRules.mapIndexed((
          secondIndex,
          element,
        ) {
          if (index == secondIndex) {
            return element.copyWith(timeFrequency: timeFrequency!);
          }
          return element;
        }).toList(),
      ),
    );
  }

  void onMandatoryBreakMinutesChange(int index, int mandatoryBreakMinutes) {
    emit(
      state.copyWith(
        driverShiftRules: state.driverShiftRules.mapIndexed((
          secondIndex,
          element,
        ) {
          if (index == secondIndex) {
            return element.copyWith(
              mandatoryBreakMinutes: mandatoryBreakMinutes,
            );
          }
          return element;
        }).toList(),
      ),
    );
  }

  // Driver Document

  Future<void> _fetchDriverDocuments() async {
    emit(state.copyWith(driverDocumentsState: const ApiResponse.loading()));

    var driverDocumentsOrError = await _driverSettingsRepository
        .getDriverDocuments();

    emit(
      state.copyWith(
        driverDocuments: driverDocumentsOrError.data!.driverDocuments,
        driverDocumentsState: driverDocumentsOrError,
      ),
    );
  }

  void addDocument() {
    emit(
      state.copyWith(
        driverDocuments: [
          ...state.driverDocuments,
          Fragment$driverDocument(
            id: "",
            numberOfImages: 1,
            hasExpiryDate: false,
            isEnabled: true,
            isRequired: true,
            notificationDaysBeforeExpiry: 0,
            title: "",
            retentionPolicies: [
              Fragment$driverDocumentRetentionPolicy(
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
        driverDocumentDeleteIds: [
          ...state.driverDocumentDeleteIds,
          state.driverDocuments[documentIndex].id,
        ],
        driverDocuments: state.driverDocuments
            .whereIndexed((index, e) => index != documentIndex)
            .toList(),
      ),
    );
  }

  void onDocumentTitleChange(int index, String title) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
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
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
          return secondIndex == index
              ? document.copyWith(isEnabled: isEnabled)
              : document;
        }).toList(),
      ),
    );
  }

  void onNumbersOfImageNeedChange(int index, int numbersOfImageNeed) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
          if (index == secondIndex) {
            return document.copyWith(numberOfImages: numbersOfImageNeed);
          }
          return document;
        }).toList(),
      ),
    );
  }

  void onNotificationDaysBeforeExpiryChange(
    int index,
    int notificationDaysBeforeExpiry,
  ) {
    final documents = state.driverDocuments;
    emit(
      state.copyWith(
        driverDocuments: documents.mapIndexed((int secondIndex, document) {
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
    final documents = state.driverDocuments;
    emit(
      state.copyWith(
        driverDocuments: documents.mapIndexed((secondIndex, document) {
          if (index == secondIndex) {
            return document.copyWith(hasExpiryDate: needExpirationDate);
          }
          return document;
        }).toList(),
      ),
    );
  }

  void onIsRequiredChange(int index, bool isRequired) {
    final documents = state.driverDocuments;
    emit(
      state.copyWith(
        driverDocuments: documents.mapIndexed((secondIndex, document) {
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
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
          return document.copyWith(
            retentionPolicies: [
              ...document.retentionPolicies,
              if (index == secondIndex)
                Fragment$driverDocumentRetentionPolicy(
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
        driverDocumentRetentionPolicyDeleteIds: [
          ...state.driverDocumentRetentionPolicyDeleteIds,
          if (state
                  .driverDocuments[documentIndex]
                  .retentionPolicies[retentionPolicyIndex]
                  .id !=
              '')
            state
                .driverDocuments[documentIndex]
                .retentionPolicies[retentionPolicyIndex]
                .id,
        ],
        driverDocuments: state.driverDocuments.mapIndexed((
          index,
          driverDocument,
        ) {
          if (index == documentIndex) {
            return driverDocument.copyWith(
              retentionPolicies: driverDocument.retentionPolicies
                  .whereIndexed(
                    (retIndex, retention) => retIndex != retentionPolicyIndex,
                  )
                  .toList(),
            );
          } else {
            return driverDocument;
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
    final retentionPolicy = state.driverDocuments[index].retentionPolicies;
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
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
        state.driverDocuments[documentIndex].retentionPolicies;
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments.mapIndexed((
          secondIndex,
          document,
        ) {
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

  Future<void> _createDriverShiftRules() async {
    final driverShiftRules = state.driverShiftRules;
    var driverShiftRuleToAdd = driverShiftRules
        .where((e) => e.id == '')
        .toList();

    if (driverShiftRuleToAdd.isNotEmpty) {
      await _driverSettingsRepository.createDriverShiftRule(
        createDriverShiftRuleInput: Input$CreateManyDriverShiftRulesInput(
          driverShiftRules: driverShiftRuleToAdd
              .map((e) => e.toInput())
              .toList(),
        ),
      );
    }
  }

  Future<void> _removeDriverShiftRules() async {
    if (state.driverShiftDeleteIds.isNotEmpty) {
      await _driverSettingsRepository.deleteDriverShiftRule(
        deleteDriverShiftRuleInput: Input$DeleteManyDriverShiftRulesInput(
          filter: Input$DriverShiftRuleDeleteFilter(
            id: Input$IDFilterComparison($in: state.driverShiftDeleteIds),
          ),
        ),
      );
    }
  }

  Future<void> _updateDriverShiftRules() async {
    final stableDriverShiftRules = state
        .driverShiftRulesState
        .data!
        .driverShiftRules
        .where((e) => e.id != '')
        .toList();

    final driverShiftRules = state.driverShiftRules
        .where((e) => e.id != '')
        .toList();

    stableDriverShiftRules.forEachIndexed((index, element) async {
      var driverShiftRule = driverShiftRules.firstWhereOrNull(
        (e) => e.id == element.id,
      );
      if (driverShiftRule != null && element != driverShiftRule) {
        await _driverSettingsRepository.updateDriverShiftRule(
          updateDriverShiftRuleInput: Input$UpdateOneDriverShiftRuleInput(
            id: driverShiftRule.id,
            update: Input$DriverShiftRuleInput(
              maxHoursPerFrequency: driverShiftRule.maxHoursPerFrequency,
              mandatoryBreakMinutes: driverShiftRule.mandatoryBreakMinutes,
              timeFrequency: driverShiftRule.timeFrequency,
            ),
          ),
        );
      }
    });
  }

  void saveChanges() async {
    await _createDriverShiftRules();
    await _removeDriverShiftRules();
    await _updateDriverShiftRules();
    await _removeDriverDocument();
    await _createDriverDocument();
    await _updateDriverDocument();
    await _removeDriverDocumentRetentionPolicy();
    await _createDriverDocumentRetentionPolicy();
    await _updateDriverDocumentRetentionPolicy();
    onStarted();
  }

  Future<void> _removeDriverDocument() async {
    if (state.driverDocumentDeleteIds.isNotEmpty) {
      await _driverSettingsRepository.deleteDriverDocument(
        deleteDriverDocumentInput: Input$DeleteManyDriverDocumentsInput(
          filter: Input$DriverDocumentDeleteFilter(
            id: Input$IDFilterComparison($in: state.driverDocumentDeleteIds),
          ),
        ),
      );
    }
  }

  Future<void> _createDriverDocument() async {
    var driverDocumentsToAdd = state.driverDocuments
        .where((e) => e.id == '')
        .toList();

    if (driverDocumentsToAdd.isNotEmpty) {
      final driverDocuments = await _driverSettingsRepository
          .createDriverDocument(
            createDriverDocumentInput: Input$CreateManyDriverDocumentsInput(
              driverDocuments: driverDocumentsToAdd
                  .map((e) => e.toInput())
                  .toList(),
            ),
          );
      if (driverDocuments.data != null) {
        for (var i = 0; i < driverDocumentsToAdd.length; i++) {
          emit(
            state.copyWith(
              driverDocuments: state.driverDocuments.mapIndexed((index, doc) {
                if (doc == driverDocumentsToAdd[i]) {
                  return doc.copyWith(
                    id: driverDocuments.data!.createManyDriverDocuments[i].id,
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

  Future<void> _updateDriverDocument() async {
    final stableDriverDocuments =
        state.driverDocumentsState.data!.driverDocuments;

    final driverDocuments = state.driverDocuments
        .where((e) => e.id != '')
        .toList();

    stableDriverDocuments.forEachIndexed((index, element) async {
      var driverDocument = driverDocuments.firstWhereOrNull(
        (e) => e.id == element.id,
      );
      if (driverDocument != null && element != driverDocument) {
        await _driverSettingsRepository.updateDriverDocument(
          updateDriverDocumentInput: Input$UpdateOneDriverDocumentInput(
            id: driverDocument.id,
            update: driverDocument.toInput(),
          ),
        );
      }
    });
  }

  Future<void> _removeDriverDocumentRetentionPolicy() async {
    if (state.driverDocumentRetentionPolicyDeleteIds.isNotEmpty) {
      await _driverSettingsRepository.deleteDriverDocumentRetentionPolicy(
        deleteDriverDocumentRetentionPolicyInput:
            Input$DeleteManyDriverDocumentRetentionPoliciesInput(
              filter: Input$DriverDocumentRetentionPolicyDeleteFilter(
                id: Input$IDFilterComparison(
                  $in: state.driverDocumentRetentionPolicyDeleteIds,
                ),
              ),
            ),
      );
    }
  }

  Future<void> _createDriverDocumentRetentionPolicy() async {
    for (final driverDocument in state.driverDocuments) {
      if (driverDocument.retentionPolicies.isEmpty) {
        continue;
      }
      if (driverDocument.id == '') {
        throw Exception(
          'All driver documents must be saved prior to this step',
        );
      }
      if (driverDocument.retentionPolicies.any((e) => e.id == '')) {
        await _driverSettingsRepository.createDriverDocumentRetentionPolicy(
          createDriverDocumentRetentionPolicyInput:
              Input$CreateManyDriverDocumentRetentionPoliciesInput(
                driverDocumentRetentionPolicies: driverDocument
                    .retentionPolicies
                    .where((e) => e.id == '')
                    .map((e) => e.toInput(driverDocument.id))
                    .toList(),
              ),
        );
      }
    }
  }

  Future<void> _updateDriverDocumentRetentionPolicy() async {
    for (final driverDocument in state.driverDocuments) {
      final stableRetentionPolicies =
          state.driverDocumentsState.data?.driverDocuments
              .firstWhereOrNull((e) => e.id == driverDocument.id)
              ?.retentionPolicies
              .toList() ??
          [];
      final currentRetentionPolicies = driverDocument.retentionPolicies
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
        await _driverSettingsRepository.updateDriverDocumentRetentionPolicy(
          updateDriverDocumentRetentionPolicyInput:
              Input$UpdateOneDriverDocumentRetentionPolicyInput(
                id: retentionPolicy.id,
                update: Input$DriverDocumentRetentionPolicyInput(
                  driverDocumentId: driverDocument.id,
                  deleteAfterDays: retentionPolicy.deleteAfterDays,
                  title: retentionPolicy.title,
                ),
              ),
        );
      }
    }
  }
}
