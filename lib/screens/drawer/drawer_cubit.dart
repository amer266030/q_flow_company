import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import '../../model/user/company.dart';
import '../../theme_data/app_theme_cubit.dart';
import 'package:get_it/get_it.dart';
import '../edit_details/edit_details_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../privacy_policy_screen.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit(BuildContext context) : super(DrawerInitial()) {
    initialLoad(context);
  }
  bool isDarkMode = true;
  bool isEnglish = false;

  var dataMgr = GetIt.I.get<DataMgr>();
  Company? company;

  initialLoad(BuildContext context) {
    company = dataMgr.company;
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

  void toggleLanguage(BuildContext context) {
    isEnglish = !isEnglish;
    context.setLocale(
        isEnglish ? const Locale('en', 'US') : const Locale('ar', 'SA'));
    _saveLocale(isEnglish);
  }

  void toggleDarkMode(BuildContext context) {
    isDarkMode = !isDarkMode;
    final themeCubit = context.read<AppThemeCubit>();
    themeCubit.changeTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    emitUpdate();
  }

  Future<void> _saveLocale(bool isEnglish) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('locale', isEnglish ? 'true' : 'false');
  }

  logout(BuildContext context) async {
    await dataMgr.logout();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()));
  }

  emitUpdate() => emit(UpdateUIState());
}
