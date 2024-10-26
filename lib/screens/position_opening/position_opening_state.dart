part of 'position_opening_cubit.dart';

@immutable
sealed class PositionOpeningState {}

final class PositionOpeningInitial extends PositionOpeningState {}

final class LoadingState extends PositionOpeningState {}

final class UpdateUIState extends PositionOpeningState {}
