import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_create_preset_dialog.state.dart';
part 'shop_detail_create_preset_dialog.bloc.freezed.dart';

class ShopDetailCreatePresetDialogBloc
    extends Cubit<ShopDetailCreatePresetDialogState> {
  final ShopDetailPresetsRepository _presetsRepository =
      locator<ShopDetailPresetsRepository>();

  ShopDetailCreatePresetDialogBloc()
    : super(ShopDetailCreatePresetDialogState());

  void onStarted({required String shopId, required String? presetId}) {
    emit(
      state.copyWith(
        shopId: shopId,
        presetId: presetId,
        presetState: presetId == null
            ? ApiResponse.loaded(null)
            : ApiResponse.loading(),
      ),
    );
    if (presetId != null) {
      _fetchPreset();
    }
  }

  Future<void> _fetchPreset() async {
    final presetOrError = await _presetsRepository.getShopItemPreset(
      id: state.presetId!,
    );
    final presetState = presetOrError;
    emit(
      state.copyWith(
        presetState: presetState,
        name: presetState.data?.name,
        availabilitySchedule: presetState.data?.weeklySchedule.toInput() ?? [],
      ),
    );
  }

  void onNameChanged(String p1) => emit(state.copyWith(name: p1));

  void onAvailabilityScheduleChanged(List<Input$WeekdayScheduleInput> p1) =>
      emit(state.copyWith(availabilitySchedule: p1));

  void onSubmit() {
    if (state.presetId == null) {
      _createPreset();
    } else {
      _updatePreset();
    }
  }

  Future<void> _createPreset() async {
    final createOrError = await _presetsRepository.createShopItemPreset(
      input: state.toCreateInput,
    );
    final createState = createOrError;
    emit(state.copyWith(submitState: createState));
  }

  Future<void> _updatePreset() async {
    final updateOrError = await _presetsRepository.updateShopItemPreset(
      id: state.presetId!,
      input: state.toUpdateInput,
    );
    final updateState = updateOrError;
    emit(state.copyWith(submitState: updateState));
  }
}
