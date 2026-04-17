import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

// fixme: move to a state
const _amount = 200;

/// Home app bar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const HomeAppBar({required this.onPressed, super.key});

  /// onPressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: kToolbarHeight * 1.1,
      title: Text(
        t.common.app.title,
        style: context.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
      leadingWidth: 100.w + 158.w,
      leading: DrawerMenuButton(onPressed: onPressed, assetIcon: LibAssets.svg.menu.path),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                offset: const Offset(0, 10),
                blurRadius: 8,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Builder(
              builder: (context) {
                final style = GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 55.sp,
                    color: const Color.fromRGBO(192, 190, 190, 1),
                    fontWeight: FontWeight.w400,
                  ),
                );
                return Text.rich(
                  style: style,
                  t.home.balance(
                    currency: (currency) => TextSpan(
                      text: '$_amount $currency',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.1);
}
