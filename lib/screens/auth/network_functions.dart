import 'package:flutter/material.dart';
import 'package:q_flow_company/screens/auth/auth_cubit.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';

import '../../supabase/supabase_auth.dart';

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

      var companies = await fetchCompanyDetails();

      if (companies != null && companies.isNotEmpty) {
        company = companies.first;
        navigateToHome(context);
      } else {
        navigateToEditDetails(
          context,
        );
      }
    } catch (e) {
      emitError('Could not verify OTP');
    }
  }

  Future fetchCompanyDetails() async {
    try {
      emitLoading();
      var companies = await SupabaseCompany.fetchCompany();
      print(companies);
      return companies;
    } catch (e) {
      print("Error loading company details: $e");
    }
  }
}
