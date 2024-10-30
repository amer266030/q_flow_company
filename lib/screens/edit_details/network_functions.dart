import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_cubit.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';

import '../../mangers/data_mgr.dart';
import '../../model/enums/user_social_link.dart';
import '../../model/social_links/social_link.dart';
import '../../supabase/supabase_social_link.dart';

extension NetworkFunctions on EditDetailsCubit {
  createNewCompany(BuildContext context) async {
    var company = Company(
      id: SupabaseMgr.shared.supabase.auth.currentUser?.id ?? '',
      name: nameController.text,
      description: descriptionController.text,
      establishedYear: '${startDate.year}',
      companySize: companySize,
    );
    try {
      emitLoading();
      var newCompany = await SupabaseCompany.createCompany(
        company: company,
        logoFile: logoFile,
      );

      Future.delayed(const Duration(seconds: 1));
      var companyId = newCompany.id;
      if (companyId == null) {
        throw Exception(
            'Could not create social links because no user was found!');
      }
      var links = createLinks(companyId);
      var socialLinks = await SupabaseSocialLink.insertLinks(links);
      newCompany.socialLinks = socialLinks;

      emitUpdate();

      dataMgr.saveCompanyData(company: company);

      if (context.mounted) {
        navigateToPositionOpening(context);
      }
    } catch (e) {
      emitError('Could not create company!\nPlease try again later.');
    }
  }

  updateCompany(BuildContext context) async {
    var company = GetIt.I.get<DataMgr>().company;

    try {
      emitLoading();
      if (company == null) throw Exception('');
      company.name = nameController.text;
      company.description = descriptionController.text;
      company.establishedYear = '${startDate.year}';
      company.companySize = companySize;

      await SupabaseCompany.updateCompany(
          imageFile: logoFile, company: company, companyId: company.id ?? '');

      var links = createLinks(company.id ?? '');
      // await SupabaseSocialLink.insertLinks(links);
      await SupabaseSocialLink.updateLinks(links);

      if (context.mounted) navigateToPositionOpening(context);
      dataMgr.saveCompanyData(company: company);
    } catch (e) {
      emitError(
          'Could not update event!\nPlease try again later.\n${e.toString()}');
    }
  }

  List<SocialLink> createLinks(String companyId) {
    return [
      SocialLink(
        companyId: companyId,
        linkType: LinkType.linkedIn,
        url: linkedInController.text,
      ),
      SocialLink(
        companyId: companyId,
        linkType: LinkType.website,
        url: websiteController.text,
      ),
      SocialLink(
        companyId: companyId,
        linkType: LinkType.twitter,
        url: xController.text,
      ),
    ];
  }
}
