import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/features/about_us/about_us.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us page
class AboutUsPage extends StatefulWidget {
  /// constructor
  const AboutUsPage({super.key});

  /// router path
  static const path = '/about-us';

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isScrolled = false;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(pageScrolled);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(pageScrolled)
      ..dispose();
    super.dispose();
  }

  void pageScrolled() {
    if (_scrollController.position.pixels > 40 && !isScrolled) {
      setState(() => isScrolled = true);
    } else if (_scrollController.position.pixels <= 40 && isScrolled) {
      setState(() => isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: SecondaryAppBar(
        centerTitle: true,
        appBarTitle: t.aboutUs.title.toUpperCase(),
        onLeadingPressed: context.read<DrawerCubit>().toggleDrawer,
        backgroundColor: isScrolled ? null : Colors.transparent,
      ),
      // appBarTitle: t.aboutUs.title.toUpperCase(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const AboutUsHeader(),
            const AboutUsWelcome(),
            const AboutUsOurMission(),
            const AboutUsHowWeServe(),
            HSB(100.h),
          ],
        ),
      ),
    );
  }
}
