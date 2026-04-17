import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history sort by
class TripHistorySortBy extends StatelessWidget {
  /// constructor
  const TripHistorySortBy({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + 80.h,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 50.w),
          child: OutlinedButton(
            style: context.theme.outlinedButtonTheme.style?.copyWith(
              side: WidgetStateProperty.all(BorderSide(width: 1.sp)),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 32.h, horizontal: 50.w),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.5.r),
                ),
              ),
            ),
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                useRootNavigator: true,
                useSafeArea: true,
                builder: (ctx) => BlocProvider.value(
                  value: BlocProvider.of<TripHistoryCubit>(context),
                  child: const TripHistorySortByContent(),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  'Sort by',
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
                ),
                WSB(40.w),
                AppSvgImage(
                  LibAssets.svg.sort.path,
                  width: 43.w,
                  height: 36.h,
                  package: 'mobile_library',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
