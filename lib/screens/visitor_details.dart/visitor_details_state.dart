part of 'visitor_details_cubit.dart';

@immutable
sealed class VisitorDetailsState {}

final class VisitorDetailsInitial extends VisitorDetailsState {}
final class LoadingState extends VisitorDetailsState {}

final class UpdateUIState extends VisitorDetailsState {}

