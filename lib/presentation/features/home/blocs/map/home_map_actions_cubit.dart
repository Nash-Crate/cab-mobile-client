import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_map_actions_cubit.freezed.dart';
part 'home_map_actions_state.dart';

/// Home map cubit
@injectable
class HomeMapActionsCubit extends Cubit<HomeMapActionsState> {
  /// constructor
  HomeMapActionsCubit() : super(const HomeMapActionsState.initial());

  /// reset the state
  void reset() => emit(const HomeMapActionsState.initial());

  /// active an action
  void activate(HomeMapAction action) => emit(HomeMapProcessing(action));

  /// failure on action activation
  void failure(HomeMapAction action, String error) => emit(HomeMapFailure(action, error));
}
