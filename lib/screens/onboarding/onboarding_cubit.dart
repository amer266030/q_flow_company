import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_screen.dart';
import 'package:q_flow_company/screens/home/home_screen.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../extensions/img_ext.dart';
import '../auth/auth_screen.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingState? previousState;
  OnboardingCubit(BuildContext context) : super(OnboardingInitial()) {
    initialLoad(context);
  }
  var idx = 0;

  initialLoad(BuildContext context) async {
    var dataMgr = GetIt.I.get<DataMgr>();
    try {
      await dataMgr.fetchData();

      if (dataMgr.company != null) {
        if (context.mounted) navigateToHome(context);
      } else if (SupabaseMgr.shared.currentUser != null) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (context.mounted) navigateToEditCompany(context);
      }
    } catch (e) {
      emitError(e.toString());
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
      'DiscoverOpportunities'.tr(),
      'ExploreVisitor'.tr()
    ),
    (
      'PreBookInterviews'.tr(),
      'EasilySchedule'.tr()
    ),
    (
      'RealTimeUpdates'.tr(),
      'StayInformed'.tr()
    )
  ];

  @override
  void emit(OnboardingState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(String msg) => emit(ErrorState(msg));
}
