part of 'i18n_cubit.dart';

/// I18nState is used to manage the state of internationalization in the application
@freezed
abstract class I18nState with _$I18nState {
  /// Factory constructor for I18nState
  const factory I18nState({
    required AppLocale appLocale,
    @Default(false) bool processing,
    String? error,
  }) = _I18nState;

  /// Initial state of the I18nState
  factory I18nState.initial() => const I18nState(appLocale: AppLocale.en);
}
