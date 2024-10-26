import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../extensions/img_ext.dart';
import '../auth/auth_screen.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  var idx = 0;

  changeIdx() {
    idx += 1;
    emit(UpdateUIState());
  }

  navigateToAuth(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));

  final List<AssetImage> images = [Img.ob1, Img.ob2, Img.ob3];
  final List<(String, String)> content = [
    (
      'Discover \nOpportunities',
      'Explore visitor profiles to find candidates that align with your needs.'
    ),
    (
      'Pre-Book \nInterviews',
      'Easily schedule interviews in advance for a smooth hiring process.'
    ),
    (
      'Real-Time \nUpdates',
      'Stay informed with instant notifications on interview schedules.'
    )
  ];
}
