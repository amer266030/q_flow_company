import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_screen.dart';
import 'package:q_flow_company/screens/home/home_screen.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';

import '../../extensions/img_ext.dart';
import '../auth/auth_screen.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(BuildContext context) : super(OnboardingInitial()) {
    initialLoad(context);
  }
  var idx = 0;

  initialLoad(BuildContext context) async {
    var dataMgr = GetIt.I.get<DataMgr>();
    await dataMgr.fetchData();
    print(SupabaseMgr.shared.currentUser?.id);
    print(dataMgr.company?.id);
    if (dataMgr.company != null) {
      navigateToHome(context);
    } else if (SupabaseMgr.shared.currentUser != null) {
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) navigateToEditCompany(context);
    }
  }

  changeIdx() {
    idx += 1;
    emit(UpdateUIState());
  }

  navigateToAuth(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()));

  navigateToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()));

  navigateToEditCompany(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EditDetailsScreen()));

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
