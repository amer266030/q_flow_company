import 'package:flutter/material.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/auth/auth_cubit.dart';
import 'package:q_flow_company/supabase/supabase_auth.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import 'package:q_flow_company/supabase/supabase_mgr.dart';

extension NetworkFunctions on AuthCubit {
  sendOTP(BuildContext context) async {
    try {
      emitLoading();
      await SupabaseAuth.sendOTP(emailController.text);
      toggleIsOtp();
    } catch (e) {
      emitError("The provided email could not be found!");
    }
  }

  verifyOTP(BuildContext context, int otp) async {
    var stringOtp = '$otp'.padLeft(6, '0');
    try {
      emitLoading();
      await SupabaseAuth.verifyOTP(
        emailController.text,
        stringOtp,
      );
      if (company != null) {
        Company companyToCheck =
            Company(id: SupabaseMgr.shared.supabase.auth.currentUser?.id);
        bool exists = await SupabaseCompany.doesCompanyExist(companyToCheck);

        if (exists) {
          navigateToHome(context);
        } else {
          navigateToEditDetails(context);
        }
      } else {
        navigateToEditDetails(context);
      }
    } catch (e) {
      emitError('Could not verify OTP');
    }
  }
}
