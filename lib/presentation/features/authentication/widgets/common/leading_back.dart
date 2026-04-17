import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// Leading back widget with button and vertical divider for Register page
class RegisterLeadingBack extends StatelessWidget {
  /// constructor
  const RegisterLeadingBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.read<AuthActionsCubit>().toLogin,
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
    );
  }
}
