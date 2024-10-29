import 'package:flutter/material.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_cubit.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import 'package:q_flow_company/supabase/supabase_mgr.dart';

extension NetworkFunctions on EditDetailsCubit {
  createNewCompany(BuildContext context) async {
    var company = Company(
      id: SupabaseMgr.shared.supabase.auth.currentUser?.id ?? '',
      name: nameController.text,
      description: descriptionController.text,
      establishedYear: startDate.year,
      companySize: companySize,
    );
    try {
      emitLoading();
      await SupabaseCompany.createCompany(
        company: company,
        logoFile: logo,
      );
      navigateToPositionOpening(context);
    } catch (e) {
      emitError('Could not create company!\nPlease try again later.');
    }
  }

  updateCompany(BuildContext context, String companyId) async {
    var company = Company(
      name: nameController.text,
      description: descriptionController.text,
      establishedYear: startDate.year,
      companySize: companySize,
    );
    try {
      emitLoading();
      await SupabaseCompany.updateCompany(
          imageFile: logo, company: company, companyId: companyId);
      if (context.mounted) navigateToPositionOpening(context);
    } catch (e) {
      emitError(
          'Could not update event!\nPlease try again later.\n${e.toString()}');
    }
  }
}
