import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Auth contents
class AuthContent extends StatefulWidget {
  /// constructor
  const AuthContent({super.key});

  @override
  State<AuthContent> createState() => _AuthContentState();
}

class _AuthContentState extends State<AuthContent> {
  // TODO(numberEdit): move this to the cubit and change it to false everytime register page is viewed
  var _editableOnRegister = false;

  late final TextEditingController _phoneNumberTec;

  @override
  void initState() {
    super.initState();
    _phoneNumberTec = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppConfigsCubit, AppConfigsState, String?>(
      selector: (state) => state.phoneCode,
      builder: (context, devicePhoneCode) {
        return BlocProvider.value(
          value: context.read<AuthFieldsCubit>()
            ..onChangeCountryCallingCode(devicePhoneCode ?? '+1'),
          child: Builder(
            builder: (context) {
              return BlocBuilder<AuthActionsCubit, AuthActionsState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedCrossFade(
                          duration: crossFadeDuration,
                          firstChild: const LoginHeader(),
                          secondChild: const RegistrationHeader(),
                          crossFadeState: state.isOnLogin
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),

                        HSB(120.h),

                        // [login] description
                        AnimatedCrossFade(
                          duration: crossFadeDuration,
                          firstChild: const LoginDescription(),
                          secondChild: const SizedBox.shrink(),
                          crossFadeState: state.isOnLogin
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),

                        // [login]/ [register] phone number
                        BlocSelector<AuthFieldsCubit, AuthFieldsState, String>(
                          selector: (state) => state.countryCallingCode.getOrCrash,
                          builder: (context, callingCode) {
                            final isEditable = !state.isOnRegister || _editableOnRegister;

                            return PhoneNumberField(
                              controller: _phoneNumberTec,
                              callingCode: callingCode,
                              onChanged: context.read<AuthFieldsCubit>().onChangePhoneNumber,
                              onCountryChanged: context
                                  .read<AuthFieldsCubit>()
                                  .onChangeCountryCallingCode,
                              label: t.common.fields.phoneNumber.label,
                              hint: t.common.fields.phoneNumber.hint,
                              isFloatingLabel: state.isOnRegister,
                              enabled: isEditable,
                              onEditableToggle: state.isOnRegister
                                  ? () => setState(() => _editableOnRegister = !_editableOnRegister)
                                  : null,
                            );
                          },
                        ),

                        // [register] middle contents
                        AnimatedCrossFade(
                          duration: crossFadeDuration,
                          firstChild: const RegistrationMiddle(),
                          secondChild: const SizedBox.shrink(),
                          crossFadeState: state.isOnRegister
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
