import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Submit button for all auth pages
class AuthSubmitButton extends StatelessWidget {
  /// constructor
  const AuthSubmitButton(this.formKey, {super.key});

  /// Form key for validation
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthActionsCubit, AuthActionsState>(
      builder: (context, state) {
        final authActionsCubit = context.read<AuthActionsCubit>();

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<AuthFieldsCubit, AuthFieldsState>(
                  buildWhen: (previous, current) =>
                      previous.isLoginStepValid != current.isLoginStepValid ||
                      previous.isRegisterStepValid != current.isRegisterStepValid ||
                      previous.isVerificationStepValid != current.isVerificationStepValid,
                  builder: (context, fieldsState) {
                    return FilledButton(
                      onPressed:
                          state is AuthActionsProcessing ||
                              (state.isOnLogin && !fieldsState.isLoginStepValid) ||
                              (state.isOnRegister && !fieldsState.isRegisterStepValid) ||
                              (state.isOnLoginVerification &&
                                  !fieldsState.isVerificationStepValid) ||
                              (state.isOnRegisterVerification &&
                                  !fieldsState.isVerificationStepValid)
                          ? null
                          : () {
                              // clear errors
                              clearAllNotifications();

                              // validate form
                              // and send request according to the step type
                              if ((formKey.currentState?.validate() ?? false) &&
                                  state is AuthActionsStep) {
                                if (state.isOnLogin) {
                                  // check if the user exists
                                  authActionsCubit.checkLoginOtp(
                                    fieldsState.countryCallingCode,
                                    fieldsState.phoneNumber,
                                  );
                                } else if (state.isOnRegister) {
                                  // register by entering the user info
                                  authActionsCubit.register(
                                    fieldsState.countryCallingCode,
                                    fieldsState.phoneNumber,
                                    fieldsState.firstName,
                                    fieldsState.lastName,
                                    isAgreeTerms: fieldsState.isAgreeTerms,
                                  );
                                } else if (state.isOnLoginVerification) {
                                  // verify login by entering the code
                                  authActionsCubit.login(
                                    fieldsState.countryCallingCode,
                                    fieldsState.phoneNumber,
                                    fieldsState.code,
                                  );
                                } else if (state.isOnRegisterVerification) {
                                  // register user by entering the code
                                  authActionsCubit.register(
                                    fieldsState.countryCallingCode,
                                    fieldsState.phoneNumber,
                                    fieldsState.firstName,
                                    fieldsState.lastName,
                                    isAgreeTerms: fieldsState.isAgreeTerms,
                                  );
                                }
                              }
                            },
                      child: state is AuthActionsProcessing
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              state.isOnLogin
                                  ? t.common.actions.cont
                                  : state.isOnRegister
                                  ? t.auth.registration.actions.signUp
                                  : state.isOnLoginVerification || state.isOnRegisterVerification
                                  ? t.auth.verification.actions.verify
                                  // will be in the processing state, loading icon will be used
                                  : '',
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
