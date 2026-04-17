import 'package:cached_network_image/cached_network_image.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip on the way widget
class TripOnTheWay extends StatelessWidget {
  /// constructor
  const TripOnTheWay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listenWhen: (m, n) => m.tripCompleted != n.tripCompleted,
      listener: (context, state) {
        if (state.tripCompleted) {
          context.flow<TripStateEnum>().update((_) => TripStateEnum.tripCompleted);
        }
      },
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
                  ),
                  child: AppSvgImage(Assets.common.callIcon.path, width: 80.w, height: 80.h),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 234, 170, 1),
                  ),
                  child: AppSvgImage(Assets.common.messageIcon.path, width: 80.w, height: 80.h),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
