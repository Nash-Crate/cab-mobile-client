import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history sort by content
class TripHistorySortByContent extends StatelessWidget {
  /// Constructor
  const TripHistorySortByContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryCubit, TripHistoryState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              children: [
                HSB(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Container(
                    width: 0.3.sw,
                    height: 4,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Text(
                    t.tripHistory.sortBy.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: const Color.fromRGBO(172, 172, 172, 1),
                    ),
                  ),
                ),
                HSB(20.h),
                ...TripHistorySortByEnum.values.map(
                  (sortBy) => RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: sortBy,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<TripHistoryCubit>().setSortBy(value);
                      }
                      Navigator.of(context).pop();
                    },
                    groupValue: state.sortBy,
                    title: Text(
                      t.tripHistory.sortBy.options[sortBy.name] ?? '',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: state.sortBy == sortBy
                            ? context.colorScheme.primary
                            : const Color.fromRGBO(18, 18, 18, 1),
                      ),
                    ),
                  ),
                ),
                HSB(20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
