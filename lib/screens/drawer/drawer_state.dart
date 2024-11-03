part of 'drawer_cubit.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {}

final class LoadingState extends DrawerState {}

final class UpdateUIState extends DrawerState {}

final class ErrorState extends DrawerState {
  final String msg;
  ErrorState(this.msg);
}
