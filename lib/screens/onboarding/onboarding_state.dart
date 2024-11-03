part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class UpdateUIState extends OnboardingState {}

final class LoadingState extends OnboardingState {}

final class ErrorState extends OnboardingState {
  final String msg;
  ErrorState(this.msg);
}
