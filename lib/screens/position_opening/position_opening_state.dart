part of 'position_opening_cubit.dart';

@immutable
sealed class PositionOpeningState {}

final class PositionOpeningInitial extends PositionOpeningState {}

final class LoadingState extends PositionOpeningState {}

final class UpdateUIState extends PositionOpeningState {}

final class ErrorState extends PositionOpeningState {
  final String msg;
  ErrorState(this.msg);
}
