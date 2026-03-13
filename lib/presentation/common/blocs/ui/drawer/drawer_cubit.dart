import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'drawer_cubit.freezed.dart';
part 'drawer_state.dart';

/// Drawer cubit
@singleton
class DrawerCubit extends Cubit<DrawerState> {
  /// constructor
  DrawerCubit() : super(const DrawerState.closed());

  /// open/ close the drawer
  void toggleDrawer() {
    if (state is DrawerOpened) return emit(const DrawerState.closed());
    emit(const DrawerState.opened());
  }
}
