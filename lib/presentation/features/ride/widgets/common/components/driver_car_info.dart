import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_library/mobile_library.dart';

/// Driver car info
class DriverCarInfo extends StatelessWidget {
  /// constructor
  const DriverCarInfo({
    required this.title,
    required this.vehicle,
    this.subTitle,
    super.key,
  });

  /// Title
  final String title;

  /// subTitle
  final String? subTitle;

  /// Vehicle
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: context.textTheme.titleSmall?.copyWith(
                  color: const Color.fromRGBO(132, 132, 132, 1),
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w200,
                ),
              ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vehicle.brand,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  vehicle.model,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${vehicle.color} • ${vehicle.licensePlate}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(121, 122, 132, 1),
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            if (vehicle.imageUrl != null) WSB(40.w),
            if (vehicle.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
                child: CachedNetworkImage(
                  height: 140.w,
                  width: 140.w,
                  imageUrl: vehicle.imageUrl!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
