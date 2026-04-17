import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Header for verification
class VerificationHeader extends StatelessWidget {
  /// constructor
  const VerificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // back button
        InkWell(
          onTap: () {
            final state = context.read<AuthActionsCubit>().state;
            if (state.isOnLoginVerification) return context.read<AuthActionsCubit>().toLogin();
            return context.read<AuthActionsCubit>().toRegister();
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: AppSvgImage(
                  LibAssets.svg.chevronLeft.path,
                  alignment: Alignment.centerLeft,
                  height: 80.h,
                  width: 180.w,
                  package: 'mobile_library',
                ),
              ),
              Container(
                height: 180.h,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                child: const VerticalDivider(thickness: 1),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 850.h,
          width: 0.6.sw,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AppImage(Assets.auth.verificationBackdrop.path, height: 458.h, width: 675.w),
              Positioned(
                top: 100.h,
                child: AppSvgImage(Assets.auth.verification.path, height: 482.h, width: 455.w),
              ),
              Positioned(
                top: 570.h,
                child: SizedBox(
                  width: .35.sw,
                  child: AppImage(Assets.auth.verificationEllipse.path),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
