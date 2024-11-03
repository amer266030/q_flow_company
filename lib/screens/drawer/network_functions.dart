import 'package:flutter/material.dart';
import 'package:q_flow_company/screens/drawer/drawer_cubit.dart';

import '../../supabase/supabase_auth.dart';

extension NetworkFunctions on DrawerCubit {
  logout(BuildContext context) async {
    try {
      emitLoading();
      await SupabaseAuth.signOut();
      previousState = null;
      if (context.mounted) navigateToOnBoarding(context);
    } catch (e) {
      emitError(e.toString());
    }
  }
}
