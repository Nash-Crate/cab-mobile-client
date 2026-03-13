import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Registration view's middle contents
class RegistrationMiddle extends StatefulWidget {
  /// Constructor
  const RegistrationMiddle({super.key});

  @override
  State<RegistrationMiddle> createState() => _RegistrationMiddleState();
}

class _RegistrationMiddleState extends State<RegistrationMiddle> {
  late final TextEditingController _firstNameTec;
  late final TextEditingController _lastNameTec;

  @override
  void initState() {
    super.initState();
    _firstNameTec = TextEditingController();
    _lastNameTec = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameTec.dispose();
    _lastNameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HSB(50.h),
        AppTextField(
          label: t.auth.registration.firstName.label,
          hint: t.auth.registration.firstName.hint,
          isFloatingLabel: true,
          controller: _firstNameTec,
          onChanged: context.read<AuthFieldsCubit>().onChangeFirstName,
        ),
        HSB(50.h),
        AppTextField(
          label: t.auth.registration.lastName.label,
          hint: t.auth.registration.lastName.hint,
          isFloatingLabel: true,
          controller: _lastNameTec,
          onChanged: context.read<AuthFieldsCubit>().onChangeLastName,
        ),
        HSB(50.h),
        BlocSelector<AuthFieldsCubit, AuthFieldsState, GenderEnum?>(
          selector: (state) => state.gender.getOrNull,
          builder: (context, gender) {
            return GenderField(
              label: t.auth.registration.gender,
              value: gender,
              onChanged: context.read<AuthFieldsCubit>().onChangeGender,
            );
          },
        ),
        HSB(200.h),
        Row(
          children: [
            Expanded(
              child: Text.rich(
                style: context.textTheme.bodySmall,
                t.auth.registration.tAndC(
                  tapHere: (text) => TextSpan(
                    text: text,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO(urlLauncher): terms and conditions link
                      },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(21.r),
                border: Border.all(
                  color: const Color.fromRGBO(211, 227, 234, 1),
                  width: 2,
                ),
              ),
              padding: EdgeInsets.all(10.w),
              child: Transform.scale(
                scale: 1.2,
                child: BlocSelector<AuthFieldsCubit, AuthFieldsState, bool>(
                  selector: (state) => state.isAgreeTerms,
                  builder: (context, isAgree) {
                    return Checkbox(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: context.colorScheme.secondary,
                      value: isAgree,
                      onChanged: (v) => context
                          .read<AuthFieldsCubit>()
                          .onChangeAgreeTerms(value: v ?? false),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
