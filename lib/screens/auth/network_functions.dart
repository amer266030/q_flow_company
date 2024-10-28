import 'package:flutter/material.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/auth/auth_cubit.dart';
import 'package:q_flow_company/supabase/supabase_auth.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';

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

      // var company = Company(id: "65adde75-c711-4298-8045-4bda88ed9225");
      // bool companyExists = await SupabaseCompany.doesCompanyExist(company);

      if (context.mounted) {
        print('Navigating to Home');
        navigateToHome(context);
        //   navigateToEditDetails(context);
      } else {
        print('context not mounted!');
      }
    } catch (e) {
      emitError('Could not verify OTP');
    }
  }
}
