part of 'drawer_cubit.dart';

/// DrawerState is used to manage the state of the drawer in the application
@freezed
class DrawerState with _$DrawerState {
  /// closed state of the drawer
  const factory DrawerState.closed() = DrawerClosed;

  /// opened state of the drawer
  const factory DrawerState.opened() = DrawerOpened;
}
