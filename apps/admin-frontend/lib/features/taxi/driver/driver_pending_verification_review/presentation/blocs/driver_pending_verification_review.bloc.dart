import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/graphql/driver_pending_verification_review.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/models/driver_pending_verification_review_services.model.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/models/driver_pending_verification_review_services_option.model.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/repositories/driver_pending_verification_review_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_pending_verification_review.state.dart';
part 'driver_pending_verification_review.bloc.freezed.dart';

class DriverPendingVerificationReviewBloc
    extends Cubit<DriverPendingVerificationReviewState> {
  final DriverPendingVerificationReviewRepository
  _driverPendingVerificationReviewRepository =
      locator<DriverPendingVerificationReviewRepository>();

  DriverPendingVerificationReviewBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverPendingVerificationReviewState(),
      );

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverReview();
  }

  Future<void> _fetchDriverReview() async {
    emit(state.copyWith(driverReviewState: const ApiResponse.loading()));

    var driverReviewOrError = await _driverPendingVerificationReviewRepository
        .getDriverReview(driverId: state.driverId!);

    emit(
      state.copyWith(
        driverReview: driverReviewOrError.data?.driver,
        originalDriverReview: driverReviewOrError.data?.driver,
        driverReviewState: driverReviewOrError,
      ),
    );
  }

  void onNextPage() {
    if (state.stepperCurrentIndex >= 0 && state.stepperCurrentIndex < 3) {
      emit(state.copyWith(stepperCurrentIndex: state.stepperCurrentIndex + 1));
    }
  }

  void onPreviousPage() {
    if (state.stepperCurrentIndex > 0) {
      emit(state.copyWith(stepperCurrentIndex: state.stepperCurrentIndex - 1));
    }
  }

  void onProfileImageChange(Fragment$Media? profileImage) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(media: profileImage),
      ),
    );
  }

  void onFirstNameChange(String firstName) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(firstName: firstName),
      ),
    );
  }

  void onLastNameChange(String lastName) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(lastName: lastName),
      ),
    );
  }

  void onEmailChange(String email) {
    emit(
      state.copyWith(driverReview: state.driverReview?.copyWith(email: email)),
    );
  }

  void onPhoneChange(String phone) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(mobileNumber: phone),
      ),
    );
  }

  void onGenderChange(Enum$Gender? gender) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(gender: gender),
      ),
    );
  }

  void onFleetChange(Fragment$fleetListItem? fleet) {
    if (fleet == null) return;
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(fleetId: fleet.id),
      ),
    );
  }

  void onCarModelChange(Fragment$vehicleModel? carModel) {
    if (carModel == null) return;
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(carId: carModel.id),
      ),
    );
  }

  void onCarColorChange(Fragment$vehicleColor? carColor) {
    if (carColor == null) return;
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(carColorId: carColor.id),
      ),
    );
  }

  void onCarProductionYearChange(int? carProductionYear) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(
          carProductionYear: carProductionYear,
        ),
      ),
    );
  }

  void onCarPlateNumberChange(String carPlateNumber) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(carPlate: carPlateNumber),
      ),
    );
  }

  // void onAccountNumberChange(String accountNumber) {
  //   emit(
  //     state.copyWith(
  //       driverReview: state.driverReview?.copyWith(
  //         accountNumber: accountNumber,
  //       ),
  //     ),
  //   );
  // }

  // void onBankNameChange(String bankName) {
  //   emit(
  //     state.copyWith(
  //       driverReview: state.driverReview?.copyWith(bankName: bankName),
  //     ),
  //   );
  // }

  // void onBankRoutingNumberChange(String bankRoutingNumber) {
  //   emit(
  //     state.copyWith(
  //       driverReview: state.driverReview?.copyWith(
  //         bankRoutingNumber: bankRoutingNumber,
  //       ),
  //     ),
  //   );
  // }

  // void onBankSwiftChange(String bankSwift) {
  //   emit(
  //     state.copyWith(
  //       driverReview: state.driverReview?.copyWith(bankSwift: bankSwift),
  //     ),
  //   );
  // }

  void onAddressChange(String address) {
    emit(
      state.copyWith(
        driverReview: state.driverReview?.copyWith(address: address),
      ),
    );
  }

  // driver documents

  Future<void> fetchDriverDocuments() async {
    // Guard: Don't re-fetch if already loaded
    if (state.driverDocumentsState.isLoaded) {
      return;
    }

    emit(state.copyWith(driverDocumentsState: const ApiResponse.loading()));

    final driverDocumentsOrFail =
        await _driverPendingVerificationReviewRepository.getDriverDocuments(
          driverId: state.driverId!,
        );

    // Use document definitions as the primary source, not uploaded documents
    final documentDefinitions =
        driverDocumentsOrFail.data?.driverDocuments ??
        <Fragment$driverDocument>[];
    final uploadedDocuments =
        driverDocumentsOrFail.data?.driverToDriverDocuments.edges
            .map((e) => e.node)
            .toList() ??
        <Fragment$driverToDriverDocument>[];

    emit(
      state.copyWith(
        driverDocumentsExpireDate: List.generate(documentDefinitions.length, (
          index,
        ) {
          // Find if driver has uploaded this document type
          final uploaded = uploadedDocuments.firstWhereOrNull(
            (doc) => doc.driverDocument.id == documentDefinitions[index].id,
          );
          return uploaded?.expiresAt == null ? true : false;
        }),
        driverDocumentsRetentionPolicy: List.generate(
          documentDefinitions.length,
          (index) {
            final uploaded = uploadedDocuments.firstWhereOrNull(
              (doc) => doc.driverDocument.id == documentDefinitions[index].id,
            );
            return uploaded?.retentionPolicy;
          },
        ),
        driverDocumentsState: driverDocumentsOrFail,
        driverDocumentsExpireDateTime: List.generate(
          documentDefinitions.length,
          (index) {
            final uploaded = uploadedDocuments.firstWhereOrNull(
              (doc) => doc.driverDocument.id == documentDefinitions[index].id,
            );
            return uploaded?.expiresAt;
          },
        ),
      ),
    );
  }

  void onDriverDocumentExpireDateChange(int index, bool value) {
    emit(
      state.copyWith(
        driverDocumentsExpireDate: state
            .driverDocumentsState
            .data!
            .driverToDriverDocuments
            .edges
            .mapIndexed((secondIndex, element) {
              if (index == secondIndex) {
                return value;
              }
              return state.driverDocumentsExpireDate[secondIndex];
            })
            .toList(),
      ),
    );
  }

  void onDriverDocumentsExpireDateTimeChange(int index, DateTime? value) {
    emit(
      state.copyWith(
        driverDocumentsExpireDateTime: state
            .driverDocumentsState
            .data!
            .driverToDriverDocuments
            .edges
            .mapIndexed((secondIndex, element) {
              if (index == secondIndex) {
                return value;
              }
              return state.driverDocumentsExpireDateTime[secondIndex];
            })
            .toList(),
      ),
    );
  }

  void onDriverDocumenRetentionPolicyChange(
    int index,
    Fragment$driverDocumentRetentionPolicy? value,
  ) {
    emit(
      state.copyWith(
        driverDocumentsRetentionPolicy: state
            .driverDocumentsState
            .data!
            .driverToDriverDocuments
            .edges
            .mapIndexed((secondIndex, element) {
              if (index == secondIndex) {
                return value;
              }
              return state.driverDocumentsRetentionPolicy[secondIndex];
            })
            .toList(),
      ),
    );
  }

  // services
  Future<void> fetchServices() async {
    // Guard: Don't re-fetch if already loaded
    if (state.servicesState.isLoaded) {
      return;
    }

    emit(state.copyWith(servicesState: const ApiResponse.loading()));

    final servicesOrFail = await _driverPendingVerificationReviewRepository
        .getServices();

    emit(
      state.copyWith(
        canDeliverServices: state.driverReview?.canDeliver ?? false,
        deliveryServicesOption: List.generate(
          Enum$DeliveryPackageSize.values
              .where((e) => e != Enum$DeliveryPackageSize.$unknown)
              .length,
          (index) =>
              Enum$DeliveryPackageSize.values[index] ==
                  state.driverReview?.maxDeliveryPackageSize
              ? DriverPendingVerificationReviewServicesOptionModel(
                  isSelectedServiceOption: true,
                  maxDeliveryPackageSize:
                      Enum$DeliveryPackageSize.values[index],
                )
              : DriverPendingVerificationReviewServicesOptionModel(),
        ),
        servicesState: servicesOrFail,
        servicesFilter:
            servicesOrFail.data?.services
                .where(
                  (e) =>
                      e.categoryId ==
                      servicesOrFail.data?.serviceCategories[0].id,
                )
                .toList() ??
            [],
        selectedServiceCheckBox:
            servicesOrFail.data?.services
                .map(
                  (e) => DriverPendingVerificationReviewServicesModel(
                    serviceId: e.id,
                    isSelectedService:
                        state.driverReview?.enabledServices.any(
                          (enabled) => enabled.service.id == e.id,
                        ) ??
                        false,
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }

  void onServiceTabChange(String id) {
    emit(
      state.copyWith(
        servicesFilter:
            state.servicesState.data?.services
                .where((e) => e.categoryId == id)
                .toList() ??
            [],
      ),
    );
  }

  void onSelectServiceChange(String id, bool value) {
    emit(
      state.copyWith(
        selectedServiceCheckBox: state.selectedServiceCheckBox.mapIndexed((
          index,
          element,
        ) {
          if (element.serviceId == id) {
            return element.copyWith(isSelectedService: value);
          }
          return element;
        }).toList(),
      ),
    );
  }

  void onCanDeliverServicesChange(bool value) {
    emit(state.copyWith(canDeliverServices: value));
  }

  void onChangeCanDeliverServicesOption(
    bool value,
    int index,
    Enum$DeliveryPackageSize option,
  ) {
    emit(
      state.copyWith(
        deliveryServicesOption: state.deliveryServicesOption.mapIndexed((
          secondIndex,
          element,
        ) {
          // Single selection: only the clicked index should be selected
          if (index == secondIndex && value) {
            return state.deliveryServicesOption[secondIndex].copyWith(
              isSelectedServiceOption: true,
              maxDeliveryPackageSize: option,
            );
          }
          // Uncheck all others
          return state.deliveryServicesOption[secondIndex].copyWith(
            isSelectedServiceOption: false,
          );
        }).toList(),
      ),
    );
  }

  void onDriverRejection(Enum$DriverStatus status) async {
    // Validation: Ensure rejection notes are provided
    if (state.rejectionNoteToStaff == null ||
        state.rejectionNoteToStaff!.trim().isEmpty) {
      emit(
        state.copyWith(
          driverRejectionState: ApiResponse.error(
            'Staff note is required for rejection',
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(driverRejectionState: const ApiResponse.loading()));

    var driverRejectionOrError =
        await _driverPendingVerificationReviewRepository.driverRejection(
          inputUpdate: Input$UpdateOneDriverInput(
            id: state.driverId!,
            update: Input$UpdateDriverInput(
              status: status,
              softRejectionNote: state.rejectionNote,
            ),
          ),
          inputCreate: Input$CreateOneDriverNoteInput(
            driverNote: Input$CreateDriverNoteInput(
              driverId: state.driverId!,
              note: state.rejectionNoteToStaff!,
            ),
          ),
        );

    emit(state.copyWith(driverRejectionState: driverRejectionOrError));
  }

  void onRejectionNoteChange(String value) {
    emit(state.copyWith(rejectionNote: value));
  }

  void onRejectionNoteToStaffChange(String value) {
    emit(state.copyWith(rejectionNoteToStaff: value));
  }

  Future<void> onApproveDriver() async {
    emit(state.copyWith(driverApproveState: const ApiResponse.loading()));

    try {
      // Step 1: Update driver details with all modified fields
      final updateDriverInput = Input$UpdateDriverInput(
        firstName: state.driverReview?.firstName,
        lastName: state.driverReview?.lastName,
        email: state.driverReview?.email,
        mobileNumber: state.driverReview?.mobileNumber,
        gender: state.driverReview?.gender,
        address: state.driverReview?.address,
        mediaId: state.driverReview?.media?.id,
        fleetId: state.driverReview?.fleetId,
        carId: state.driverReview?.carId,
        carColorId: state.driverReview?.carColorId,
        carProductionYear: state.driverReview?.carProductionYear,
        carPlate: state.driverReview?.carPlate,
        canDeliver: state.canDeliverServices,
        maxDeliveryPackageSize: state.deliveryServicesOption
            .firstWhereOrNull((e) => e.isSelectedServiceOption == true)
            ?.maxDeliveryPackageSize,
        status: Enum$DriverStatus.Offline,
      );

      final driverUpdateResult =
          await _driverPendingVerificationReviewRepository.driverApprove(
            input: Input$UpdateOneDriverInput(
              id: state.driverId!,
              update: updateDriverInput,
            ),
          );

      if (driverUpdateResult.isError) {
        emit(state.copyWith(driverApproveState: driverUpdateResult));
        return;
      }

      // Step 2: Update driver documents with expiry dates and retention policies
      if (state.driverDocumentsState.isLoaded) {
        final documents =
            state.driverDocumentsState.data?.driverToDriverDocuments.edges
                .map((e) => e.node)
                .toList() ??
            <Fragment$driverToDriverDocument>[];

        for (int i = 0; i < documents.length; i++) {
          final document = documents[i];
          final retentionPolicy = state.driverDocumentsRetentionPolicy[i];
          final expiresAt = state.driverDocumentsExpireDate[i]
              ? null
              : state.driverDocumentsExpireDateTime[i];

          // Only update if something changed
          if (retentionPolicy != null || expiresAt != document.expiresAt) {
            await _driverPendingVerificationReviewRepository
                .updateDriverDocument(
                  input: Input$UpdateOneDriverToDriverDocumentInput(
                    id: document.id,
                    update: Input$DriverToDriverDocumentInput(
                      driverId: state.driverId!,
                      driverDocumentId: document.driverDocument.id,
                      mediaId: document.media.id,
                      retentionPolicyId:
                          retentionPolicy?.id ??
                          document.retentionPolicy?.id ??
                          '',
                      expiresAt: expiresAt,
                    ),
                  ),
                );
          }
        }
      }

      // Step 3: Set enabled services based on selected checkboxes
      if (state.servicesState.isLoaded) {
        final selectedServiceIds = state.selectedServiceCheckBox
            .where((e) => e.isSelectedService == true)
            .map((e) => e.serviceId)
            .whereType<String>()
            .toList();

        if (selectedServiceIds.isNotEmpty) {
          await _driverPendingVerificationReviewRepository.setEnabledServices(
            input: Input$SetActiveServicesOnDriverInput(
              driverId: state.driverId!,
              serviceIds: selectedServiceIds,
            ),
          );
        }
      }

      // All steps completed successfully
      emit(state.copyWith(driverApproveState: driverUpdateResult));
    } catch (error) {
      emit(
        state.copyWith(driverApproveState: ApiResponse.error(error.toString())),
      );
    }
  }
}
