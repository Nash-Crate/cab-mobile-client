part of 'onboarding_slides.dart';

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: .1.sh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      // [NOTE]: Flutter bug, fontWeight not updated when using from the theme
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 85.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    HSB(10.h),
                    Text(subTitle, style: context.textTheme.displaySmall),
                  ],
                ),
                Center(
                  child: SizedBox(
                    height: .4.sh,
                    child: AppSvgImage(icon, height: .2.sh),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: .7.sw,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  description,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
