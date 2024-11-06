import 'package:easy_localization/easy_localization.dart';
import 'package:q_flow_company/model/enums/user_social_link.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/social_links/social_link.dart';
import 'client/supabase_mgr.dart';

class SupabaseSocialLink {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'social_link';

  static insertLinks(List<SocialLink> links) async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

    try {
      final socialLinksData = links.map((link) {
        link.companyId = companyId;
        return link.toJson();
      }).toList();

      var createdLinks =
          await supabase.from('social_link').insert(socialLinksData).select();
      return createdLinks;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateLinks(List<SocialLink> links) async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

    try {
      // Use Future.wait to run updates concurrently
      await Future.wait(links.map((link) async {
        link.companyId = companyId;

        await supabase
            .from(tableKey)
            .update(link.toJson())
            .eq('company_id', '${link.companyId}')
            .eq('link_type', '${link.linkType?.value}');
      }));
    } catch (e) {
      rethrow;
    }
  }
}
