import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_client/presentation/features/home/home.dart';
import 'package:mobile_client/presentation/features/onboarding/onboarding.dart';
import 'package:mobile_client/presentation/features/splash/splash.dart';
import 'package:mobile_library/mobile_library.dart';

/// Splash page
class SplashPage extends StatefulWidget {
  /// constructor
  const SplashPage({super.key});

  /// router path
  static String path = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? _nextRoutePath;
  bool _splashDone = false;
  bool? _toOnBoarding;

  int _bgScale = 3;
  bool _contentVisible = false;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // trigger cubit initialization
    unawaited(context.read<OnboardingCubit>().init());
    unawaited(context.read<AuthActionsCubit>().init());

    _initialize();
    // });
  }

  void _navigate() {
    if (!_splashDone) return;

    // trigger navigate validation
    _navigateValidation();
    if (_nextRoutePath != null) context.go(_nextRoutePath!);
  }

  void _initialize() {
    // splash complete timer
    Future<void>.delayed(const Duration(seconds: 3)).then((value) {
      setState(() => _splashDone = true);
      _navigate();
    });

    Future<void>.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() => _bgScale = 1);

      // after 2 more seconds, display the logo
      Future<void>.delayed(const Duration(seconds: 2)).then((value) {
        setState(() => _contentVisible = true);

        // trigger navigation
        _navigate();
      });
    });
  }

  void _navigateValidation() {
    // check onboarding viewed status
    final authState = context.read<AuthActionsCubit>().state;
    // check previous authentication status
    if (authState is Authenticated) {
      setState(() => _nextRoutePath = HomePage.path);
    }
    // if in processing, wait for processing to complete
    // BlocListener will re-trigger this once it's done
    else if (authState is! AuthActionsProcessing) {
      if (_toOnBoarding ?? false) {
        return setState(() => _nextRoutePath = OnboardingPage.path);
      }
      setState(() => _nextRoutePath = AuthPage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is! OnboardingInitial) {
              setState(() => _toOnBoarding = state is ShowOnboarding);
              // trigger navigate on onboarding value change
              _navigate();
            }
          },
        ),
        BlocListener<AuthActionsCubit, AuthActionsState>(
          listener: (context, state) {
            // any state other than processing will trigger navigation
            if (state is! AuthActionsProcessing) _navigate();
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            OverflowBox(
              maxWidth: 3.sw,
              maxHeight: 3.sh,
              child: AnimatedContainer(
                width: _bgScale.sw,
                height: _bgScale.sh,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: AppSvgImage(Assets.splash.map.path),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _bgScale == 1 ? 1 : 0,
                curve: Curves.easeIn,
                duration: const Duration(seconds: 2),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1],
                      colors: <Color>[
                        Color.fromRGBO(255, 199, 39, 0.59),
                        Color.fromRGBO(255, 199, 39, 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SplashLogo(visible: _contentVisible),
            AnimatedOpacity(
              opacity: _contentVisible ? 1 : 0,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    t.common.app.title,
                    style: context.textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
