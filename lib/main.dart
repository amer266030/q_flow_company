import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:q_flow_company/screens/auth/auth_screen.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_screen.dart';
import 'package:q_flow_company/screens/home/home_screen.dart';
import 'package:q_flow_company/screens/onboarding/onboarding_screen.dart';
import 'package:q_flow_company/screens/position_opening/position_opening_screen.dart';
import 'package:q_flow_company/services/di_container.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:q_flow_company/theme_data/app_theme_cubit.dart';
import 'package:q_flow_company/theme_data/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseMgr.shared.initialize();
  await EasyLocalization.ensureInitialized();
  await DIContainer.setup();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeCubit(),
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: const OnboardingScreen());
        },
      ),
    );
  }
}
