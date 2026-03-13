import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Verification pin code section
class VerificationPinCode extends StatefulWidget {
  /// Constructor
  const VerificationPinCode({super.key});

  @override
  State<VerificationPinCode> createState() => _VerificationPinCodeState();
}

class _VerificationPinCodeState extends State<VerificationPinCode> {
  late TextEditingController _codeController;
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    super.initState();

    // will be auto disposed from the library
    _codeController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthFieldsCubit, AuthFieldsState, VerificationCode>(
      selector: (state) => state.code,
      builder: (context, state) {
        return AppPinCodeField(
          controller: _codeController,
          onCompleted: (code) {
            final fieldsState = context.read<AuthFieldsCubit>().state;
            context.read<AuthActionsCubit>().login(
                  fieldsState.countryCallingCode,
                  fieldsState.phoneNumber,
                  fieldsState.code,
                );
          },
          onChanged: context.read<AuthFieldsCubit>().onChangeCode,
          validator: (v) {
            // TODO(pin): complete
            // return cubit.state.pin.value.fold(
            //   (f) => f.maybeMap(
            //     invalidVerificationCode: (fv) {
            //       if (cubit.state.showErrors && v != null && v.length > 5) {
            //         errorController.add(ErrorAnimationType.shake);
            //         return t.verification.errors.incorrectCode;
            //       }
            //       return null;
            //     },
            //     orElse: () => null,
            //   ),
            //   (s) => null,
            // );
            return null;
          },
        );
      },
    );
  }
}
