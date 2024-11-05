import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user/company.dart';
import '../../theme_data/app_theme_cubit.dart';
import 'package:get_it/get_it.dart';
import '../edit_details/edit_details_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../privacy_policy_screen.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerState? previousState;
  DrawerCubit(BuildContext context) : super(DrawerInitial()) {
    initialLoad(context);
  }
  bool isDarkMode = true;
  bool isEnglish = true;

  var dataMgr = GetIt.I.get<DataMgr>();
  Company? company;

  initialLoad(BuildContext context) async {
    company = dataMgr.company;

    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');
    isDarkMode = (savedTheme == ThemeMode.dark.toString());
    final savedLocale = prefs.getString('locale');
    isEnglish = (savedLocale == 'en_US');

    emitUpdate();
  }

  void toggleLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    isEnglish = !isEnglish;
    await prefs.setString('locale', isEnglish ? 'en_US' : 'ar_SA');
    if (context.mounted) {
      context.setLocale(
          isEnglish ? const Locale('en', 'US') : const Locale('ar', 'SA'));
    }
    emitUpdate();
  }

  void toggleDarkMode(BuildContext context) {
    isDarkMode = !isDarkMode;
    final themeCubit = context.read<AppThemeCubit>();
    themeCubit.changeTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    emitUpdate();
  }

  navigateToEditDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditDetailsScreen(
                  company: company,
                  isInitialSetup: true,
                )))
        .then((_) async {
      try {
        var company = await SupabaseCompany.fetchCompany();
        if (company != null) {
          if (context.mounted) initialLoad(context);
        }
      } catch (_) {}
    });
  }

  navigateToPrivacyPolicy(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));

  navigateToOnBoarding(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        (route) => false,
      );

  @override
  void emit(DrawerState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
}
