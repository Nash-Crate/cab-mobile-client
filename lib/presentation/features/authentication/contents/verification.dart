import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Authentication verification content
class AuthVerificationContent extends StatelessWidget {
  /// constructor
  const AuthVerificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthActionsCubit, AuthActionsState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: Column(
                children: [
                  const VerificationHeader(),
                  HSB(10.h),
                  Row(
                    children: [
                      Text(
                        t.auth.verification.codeSent,
                        style: context.textTheme.displayLarge?.copyWith(fontSize: 80.sp),
                      ),
                    ],
                  ),
                  HSB(60.h),
                  Row(
                    children: [
                      Text.rich(
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        t.auth.verification.onNumber(
                          number: (_) => TextSpan(
                            text: context.read<AuthFieldsCubit>().fullPhoneNumber.getOrNull ?? '',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HSB(80.h),
                  Text(
                    t.auth.verification.enterCode,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(146, 146, 146, 1),
                    ),
                  ),
                  HSB(80.h),
                ],
              ),
            ),
            const VerificationPinCode(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: Column(
                children: [
                  HSB(80.h),
                  Builder(
                    builder: (context) {
                      final style = GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 43.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(106, 106, 106, 1),
                        ),
                      );
                      return Text.rich(
                        style: style,
                        t.auth.verification.notReceived(
                          resend: (text) => TextSpan(
                            text: text,
                            style: style.copyWith(
                              fontSize: 48.sp,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  HSB(80.h),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
