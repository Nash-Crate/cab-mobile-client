import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_client/presentation/features/onboarding/onboarding.dart';
import 'package:mobile_client/presentation/routing/router.dart';
import 'package:mobile_client/presentation/theme/theme.dart';

/// BotToast builder
final TransitionBuilder botToastBuilder = BotToastInit();

/// Main app
class App extends StatefulWidget {
  /// constructor
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // pre-cache asset images
      await _preCacheAssetImages();
    });
  }

  Future<void> _preCacheAssetImages() async {
    await Future.wait([
      precacheImage(AssetImage(Assets.logo.logo.path), context),
      precacheImage(AssetImage(Assets.auth.headerBg.path), context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // translations wrapper
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AppConfigsCubit>(), lazy: false),
          BlocProvider(create: (context) => getIt<I18nCubit>()),
          BlocProvider(create: (context) => getIt<OnboardingCubit>()),
          BlocProvider(create: (context) => getIt<AuthActionsCubit>()),
          BlocProvider(create: (context) => getIt<DrawerCubit>()),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<I18nCubit, I18nState>(
              buildWhen: (prev, curr) => prev.appLocale.languageCode != curr.appLocale.languageCode,
              builder: (context, state) {
                // Material app with router
                return MaterialApp.router(
                  onGenerateTitle: (context) => t.common.app.title,
                  debugShowCheckedModeBanner: false,
                  builder: (ctx, child) {
                    // initialise screen util
                    ScreenUtil.init(ctx, designSize: const Size(1296, 2804));

                    // set theme separately to use the screenutil font sizes
                    return Theme(data: lightTheme, child: botToastBuilder(context, child));
                  },
                  routerConfig: appRouter,
                  locale: TranslationProvider.of(context).flutterLocale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
