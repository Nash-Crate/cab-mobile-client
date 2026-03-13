part of 'app_configs_cubit.dart';

/// AppConfigsState is used to manage the state of application configurations
@freezed
abstract class AppConfigsState with _$AppConfigsState {
  /// Factory constructor for AppConfigsState
  const factory AppConfigsState({
    String? phoneCode,
  }) = _AppConfigsState;

  /// Initial state of the AppConfigsState
  factory AppConfigsState.initial() => const AppConfigsState();
}
