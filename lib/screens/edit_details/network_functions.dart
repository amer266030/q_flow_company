import 'package:flutter/material.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_cubit.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';

extension NetworkFunctions on EditDetailsCubit {
  Future createNewCompany(BuildContext context) async {
    try {
      emitLoading();
      var response = await SupabaseCompany.createCompany(
        company: Company(
          name: nameController.text,
          description: descriptionController.text,
          establishedYear: startDate.year,
          companySize: companySize,
        ),
        logoFile: logo,
      );

      print(response);

      emitUpdate();
      // if (context.mounted) {
      //   Navigator.of(context).pop(); // Now, try to pop the context
      // }
    } catch (e) {
      print(e.toString());
      emitUpdate();
      if (context.mounted) {
        // showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
