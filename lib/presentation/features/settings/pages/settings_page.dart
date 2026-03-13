import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_library/mobile_library.dart';

/// Settings page
class SettingsPage extends StatelessWidget {
  /// constructor
  const SettingsPage({super.key});

  /// router path
  static const path = '/settings';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: SecondaryAppBar(
        centerTitle: true,
        appBarTitle: t.settings.title.toUpperCase(),
        onLeadingPressed: context.read<DrawerCubit>().toggleDrawer,
        // backgroundColor: isScrolled ? null : Colors.transparent,
      ),
      body: const Center(child: Text(path)),
    );
  }
}
