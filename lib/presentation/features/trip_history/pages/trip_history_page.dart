import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history page
class TripHistoryPage extends StatelessWidget {
  /// constructor
  const TripHistoryPage({super.key});

  /// router path
  static const String path = '/trip_history';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TripHistoryCubit>()..fetch(),
      child: Builder(
        builder: (context) {
          return AppScaffold(
            appBar: SecondaryAppBar(
              centerTitle: true,
              appBarTitle: t.tripHistory.title.toUpperCase(),
              onLeadingPressed: context.read<DrawerCubit>().toggleDrawer,
              // backgroundColor: isScrolled ? null : Colors.transparent,
            ),
            body: const TripHistoryContent(),
          );
        },
      ),
    );
  }
}
