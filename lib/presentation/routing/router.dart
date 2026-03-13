import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/presentation/features/about_us/about_us.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_client/presentation/features/contact_us/contact_us.dart';
import 'package:mobile_client/presentation/features/home/home.dart';
import 'package:mobile_client/presentation/features/onboarding/onboarding.dart';
import 'package:mobile_client/presentation/features/settings/settings.dart';
import 'package:mobile_client/presentation/features/splash/splash.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

part 'custom_extra_codec.dart';
part 'route_extras/trip_details.dart';

/// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: SplashPage.path,
  observers: [BotToastNavigatorObserver()],
  extraCodec: const CustomExtraCodec(),
  routes: [
    GoRoute(
      path: SplashPage.path,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: OnboardingPage.path,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AuthPage.path,
      builder: (context, state) => const AuthPage(),
    ),
    ShellRoute(
      builder: (context, state, body) => DrawerWrapper(body),
      routes: [
        GoRoute(
          path: HomePage.path,
          pageBuilder: (context, state) =>
              _fade(context, state, const HomePage()),
        ),
        GoRoute(
          path: TripHistoryPage.path,
          pageBuilder: (context, state) =>
              _fade(context, state, const TripHistoryPage()),
          routes: [
            GoRoute(
              path: TripHistoryDetailsPage.path,
              pageBuilder: (context, state) => _slideLeft(
                context,
                state,
                const TripHistoryPage(),
                const TripHistoryDetailsPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AboutUsPage.path,
          pageBuilder: (context, state) =>
              _fade(context, state, const AboutUsPage()),
        ),
        GoRoute(
          path: ContactUsPage.path,
          pageBuilder: (context, state) =>
              _fade(context, state, const ContactUsPage()),
        ),
        GoRoute(
          path: SettingsPage.path,
          pageBuilder: (context, state) =>
              _fade(context, state, const SettingsPage()),
        ),
      ],
    ),
  ],
);

// Custom page transitions
CustomTransitionPage<void> _fade(
  BuildContext context,
  GoRouterState state,
  Widget page,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

CustomTransitionPage<void> _slideLeft(
  BuildContext context,
  GoRouterState state,
  Widget exitPage,
  Widget page,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: <Widget>[
          SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).chain(
                CurveTween(curve: Curves.easeIn),
              ),
            ),
            child: exitPage,
          ),
          SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.easeIn),
              ),
            ),
            child: page,
          ),
        ],
      );
    },
  );
}
