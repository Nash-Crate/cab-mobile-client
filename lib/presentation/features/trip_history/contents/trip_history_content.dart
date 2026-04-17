import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';

/// Trip history content
class TripHistoryContent extends StatefulWidget {
  /// constructor
  const TripHistoryContent({super.key});

  @override
  State<TripHistoryContent> createState() => _TripHistoryContentState();
}

class _TripHistoryContentState extends State<TripHistoryContent> {
  late ScrollController _controller;
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final cubit = context.read<TripHistoryCubit>();
    if (_controller.position.extentAfter < 500 && cubit.state.hasMore) await cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: const [
        TripHistorySortBy(),
        TripHistoryList(),
      ],
    );
  }
}
