import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/onboarding/onboarding.dart';
import 'package:mobile_library/mobile_library.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'onboarding_slide.dart';

/// Onboarding slides
final slides = [
  _OnboardingSlide(
    title: t.onboarding.slides.smoothAndQuick.title,
    subTitle: t.onboarding.slides.smoothAndQuick.subtitle,
    description: t.onboarding.slides.smoothAndQuick.description,
    icon: Assets.onboardingSmoothQuickIcon,
  ),
  _OnboardingSlide(
    title: t.onboarding.slides.findNearby.title,
    subTitle: t.onboarding.slides.findNearby.subtitle,
    description: t.onboarding.slides.findNearby.description,
    icon: Assets.onboardingFindNearbyIcon,
  ),
  _OnboardingSlide(
    title: t.onboarding.slides.feelCozy.title,
    subTitle: t.onboarding.slides.feelCozy.subtitle,
    description: t.onboarding.slides.feelCozy.description,
    icon: Assets.onboardingFeelCozyIcon,
  ),
];

/// Onboarding slides
class OnboardingSlides extends StatefulWidget {
  /// constructor
  const OnboardingSlides({super.key});

  @override
  State<OnboardingSlides> createState() => _OnboardingSlidesState();
}

class _OnboardingSlidesState extends State<OnboardingSlides> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const OnboardingBackground(),
        CarouselSlider.builder(
          itemCount: slides.length,
          itemBuilder: (context, itemIndex, pageViewIndex) => slides[itemIndex],
          options: CarouselOptions(
            height: 1.sh - 100,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) => setState(() => activeIndex = index),
          ),
        ),
        Positioned(
          bottom: 1.sh * .25 - 40.h,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: slides.length,
              effect: WormEffect(
                dotColor: const Color.fromRGBO(236, 236, 236, 1),
                activeDotColor: Colors.black,
                dotHeight: 36.h,
                dotWidth: 36.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
