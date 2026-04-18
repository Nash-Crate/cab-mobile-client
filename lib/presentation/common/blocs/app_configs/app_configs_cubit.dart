import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/usecases/usecases.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_library/mobile_library.dart';

part 'app_configs_cubit.freezed.dart';

part 'app_configs_state.dart';

/// App configs cubit
@singleton
class AppConfigsCubit extends Cubit<AppConfigsState> {
  /// constructor
  AppConfigsCubit(this._getDevicePhoneCode) : super(AppConfigsState.initial()) {
    unawaited(init());
  }

  final GetDevicePhoneCode _getDevicePhoneCode;

  /// init
  Future<void> init() async {
    await Future.wait([setDevicePhoneCode(), setCurrentLocation()]);
  }

  /// get device phone code and set
  Future<void> setDevicePhoneCode() async {
    emit(state.copyWith(processing: Map.of(state.processing)..[ProcessingType.phoneCode] = true));

    final result = await _getDevicePhoneCode();

    if (result.isRight() && result.asR != null) emit(state.copyWith(phoneCode: result.asR));

    emit(state.copyWith(processing: Map.of(state.processing)..[ProcessingType.phoneCode] = false));
  }

  /// Get the current location of the user
  Future<void> setCurrentLocation() async {
    emit(
      state.copyWith(
        processing: Map.of(state.processing)..[ProcessingType.getCurrentLocation] = true,
      ),
    );

    final l = await getCurrentLocation;

    emit(
      state.copyWith(
        currentLocation: LatLong(latitude: l.latitude, longitude: l.longitude),
        processing: Map.of(state.processing)..[ProcessingType.getCurrentLocation] = false,
      ),
    );
  }
}
