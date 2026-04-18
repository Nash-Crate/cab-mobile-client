part of 'app_configs_cubit.dart';

/// AppConfigsState is used to manage the state of application configurations
@freezed
abstract class AppConfigsState with _$AppConfigsState {
  /// Factory constructor for AppConfigsState
  const factory AppConfigsState({
    required Map<ProcessingType, bool> processing,
    String? phoneCode,
    LatLong? currentLocation,
  }) = _AppConfigsState;

  /// Initial state of the AppConfigsState
  factory AppConfigsState.initial() => const AppConfigsState(
    processing: {
      ProcessingType.phoneCode: true,
      ProcessingType.getCurrentLocation: true,
    },
  );

  const AppConfigsState._();

  /// Getter to check if any processing is currently happening
  bool get isProcessing => processing.values.any((isProcessing) => isProcessing);
}

/// Enum to represent the type of processing being done in AppConfigsCubit
enum ProcessingType {
  /// Processing phone code
  phoneCode,

  /// Processing current location
  getCurrentLocation,
}
