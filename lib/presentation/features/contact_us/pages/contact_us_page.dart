import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/features/contact_us/contact_us.dart';
import 'package:mobile_library/mobile_library.dart';

/// Contact us page
class ContactUsPage extends StatelessWidget {
  /// constructor
  const ContactUsPage({super.key});

  /// router path
  static const path = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: SecondaryAppBar(
        centerTitle: true,
        appBarTitle: t.contactUs.title.toUpperCase(),
        onLeadingPressed: context.read<DrawerCubit>().toggleDrawer,
        // backgroundColor: isScrolled ? null : Colors.transparent,
      ),
      backgroundColor: const Color.fromRGBO(255, 215, 100, 0.6),
      body: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 1.sh),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, .18, 1],
              colors: [
                Color.fromRGBO(255, 215, 100, 0.6),
                Colors.white,
                Color.fromRGBO(199, 236, 205, 0.4),
              ],
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                ContactUsHeader(),
                ContactUsForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
