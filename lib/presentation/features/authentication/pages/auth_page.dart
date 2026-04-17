import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_client/presentation/features/home/home.dart';
import 'package:mobile_library/mobile_library.dart';

/// Authentication page
class AuthPage extends StatefulWidget {
  /// constructor
  const AuthPage({super.key});

  /// router path
  static const String path = '/svg';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthFieldsCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<AuthActionsCubit, AuthActionsState>(
            listener: (context, state) {
              // change route only on [Authenticated], other states will change the widgets order
              if (state is Authenticated) context.go(HomePage.path);
            },
            child: Scaffold(
              body: Stack(
                children: [
                  SizedBox(height: 0.5.sh, child: const HeaderBg()),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(top: 100.h, bottom: 100.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(88.r)),
                          ),
                          child: BlocBuilder<AuthActionsCubit, AuthActionsState>(
                            builder: (context, state) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    AnimatedCrossFade(
                                      duration: crossFadeDuration,
                                      firstChild: const AuthContent(),
                                      secondChild: const AuthVerificationContent(),
                                      crossFadeState:
                                          !state.isOnLoginVerification &&
                                              !state.isOnRegisterVerification
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),

                                    // submit button for all contents
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                                      child: AuthSubmitButton(_formKey),
                                    ),

                                    // [login] footer
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                                      child: AnimatedCrossFade(
                                        duration: crossFadeDuration,
                                        firstChild: const LoginFooter(),
                                        secondChild: const SizedBox.shrink(),
                                        crossFadeState: state.isOnLogin
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
