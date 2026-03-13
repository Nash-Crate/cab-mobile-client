import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/usecases/usecases.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/extensions/extensions.dart';
import 'package:mobile_library/mobile_library.dart';

part 'i18n_cubit.freezed.dart';
part 'i18n_state.dart';

/// Internationalization state
@singleton
class I18nCubit extends Cubit<I18nState> {
  /// constructor
  I18nCubit(this._getCachedLanguageCode, this._cacheLanguageCode) : super(I18nState.initial());

  final GetCachedLanguageCode _getCachedLanguageCode;
  final CacheLanguageCode _cacheLanguageCode;

  /// get the cached locale and set it app wide
  Future<void> init() async {
    final result = await _getCachedLanguageCode();

    if (result.isRight() && result.asR != null) {
      final appLocale = _getAppLocaleFromLanguageCode(result.asR!);

      // set translation file
      await LocaleSettings.setLocale(appLocale);
      return emit(state.copyWith(appLocale: appLocale));
    }
  }

  /// change the app locale
  Future<void> changeAppLocale(String languageCode) async {
    emit(state.copyWith(processing: true));
    final result = await _cacheLanguageCode(languageCode);

    if (result.isLeft()) {
      addError(result.asL);
      return emit(state.copyWith(error: result.asL.message, processing: false));
    }

    // set translation file
    final locale = _getAppLocaleFromLanguageCode(languageCode);
    await LocaleSettings.setLocale(locale);
    return emit(state.copyWith(appLocale: locale, processing: false));
  }

  /// get the app locale from the language code
  AppLocale _getAppLocaleFromLanguageCode(String languageCode) {
    return AppLocale.values.firstWhere(
      (al) => al.languageCode == languageCode,
      orElse: () => AppLocale.en,
    );
  }
}
