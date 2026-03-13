import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_client/presentation/routing/router.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history details page
class TripHistoryDetailsPage extends StatefulWidget {
  /// constructor
  const TripHistoryDetailsPage({super.key});

  /// Trip history details page route
  static const path = 'details';

  /// route to use with push
  static const pushPath = '${TripHistoryPage.path}/$path';

  @override
  State<TripHistoryDetailsPage> createState() => _TripHistoryDetailsPageState();
}

class _TripHistoryDetailsPageState extends State<TripHistoryDetailsPage> {
  @override
  void initState() {
    super.initState();
    // fixme
    // final goExtra = GoRouterState.of(context).extra;
    // final data = goExtra is TripDetailsRouteExtra ? goExtra : null;
    // if (data == null) return context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        final goExtra = GoRouterState.of(context).extra;
        final data = goExtra is TripDetailsRouteExtra ? goExtra : null;
        return getIt<TripHistoryDetailsCubit>(param1: data!.toTrip())..fetch();
      },
      child: Builder(
        builder: (context) {
          return AppScaffold(
            appBar: SecondaryAppBar(
              centerTitle: true,
              appBarTitle: t.tripHistory.details.title.toUpperCase(),
              appBarLeading: const SecondaryAppBarLeading(),
              // backgroundColor: isScrolled ? null : Colors.transparent,
            ),
            body: const TripDetails(),
          );
        },
      ),
    );
  }
}
