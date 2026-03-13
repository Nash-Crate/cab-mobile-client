import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/blocs/blocs.dart';
import 'package:mobile_library/mobile_library.dart';

/// footer for Login content
class LoginFooter extends StatelessWidget {
  /// constructor
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HSB(50.h),
        Divider(thickness: 1.w, indent: 20.w, endIndent: 20.w),
        HSB(100.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true,
                  useSafeArea: true,
                  builder: (context) => BlocSelector<I18nCubit, I18nState, String>(
                    selector: (state) => state.appLocale.languageCode,
                    builder: (context, activeLocale) {
                      return LanguageSelectView(
                        activeLocale: activeLocale,
                        appLocales: AppLocale.values.map((a) => a.languageCode).toList(),
                        onSelected: (locale) {
                          context.read<I18nCubit>().changeAppLocale(locale);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.common.language.title.active),
                    Icon(
                      Icons.expand_more_sharp,
                      color: context.theme.outlinedButtonTheme.style?.foregroundColor?.resolve({
                        WidgetState.focused,
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
