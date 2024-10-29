part of 'edit_details_cubit.dart';

@immutable
sealed class EditDetailsState {}

final class EditDetailsInitial extends EditDetailsState {}

final class LoadingState extends EditDetailsState {}

final class UpdateUIState extends EditDetailsState {}

final class ErrorState extends EditDetailsState {
  final String msg;
  ErrorState(this.msg);
}
