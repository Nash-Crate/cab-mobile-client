import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/blocs/blocs.dart';
import 'package:mobile_library/mobile_library.dart';

/// Ride driver contact
class RideDriverContact extends StatelessWidget {
  /// constructor
  const RideDriverContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideCubit, RideState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 40.h),
              child: Row(
                children: [
                  if (state.driver?.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      child: CachedNetworkImage(
                        height: 140.w,
                        width: 140.w,
                        imageUrl: state.driver!.imageUrl!,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  if (state.driver?.imageUrl != null) WSB(40.w),
                  Text(
                    state.driver?.name ?? '-',
                    maxLines: 3,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 57.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WSB(40.w),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 234, 170, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: AppSvgImage(Assets.common.callIcon.path, width: 50.w, height: 50.w),
                ),
                WSB(40.w),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 234, 170, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: AppSvgImage(Assets.common.messageIcon.path, width: 50.w, height: 50.w),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
