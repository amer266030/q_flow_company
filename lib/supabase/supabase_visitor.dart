import 'package:get_it/get_it.dart';
import 'package:q_flow_company/model/skills/skill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mangers/data_mgr.dart';
import '../model/interview.dart';
import '../model/social_links/social_link.dart';
import '../model/user/visitor.dart';
import 'client/supabase_mgr.dart';

class SupabaseVisitor {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'visitor';
  static const String avatarBucketKey = 'visitor_avatar';
  static const String resumeBucketKey = 'visitor_resume';
  static final dataMgr = GetIt.I.get<DataMgr>();

  static Future<List<Visitor>> fetchVisitors() async {
    try {
      // Fetch all visitors with their social links
      final response = await supabase
          .from('visitor')
          .select('*, social_link(*), interview(*), skill(*)');

      // Parse each visitor record and include social links if they exist
      final visitors = (response as List).map((visitorData) {
        final visitor = Visitor.fromJson(visitorData);

        // Check and parse social links
        if (visitorData['social_link'] != null) {
          visitor.socialLinks = (visitorData['social_link'] as List)
              .map((link) => SocialLink.fromJson(link))
              .toList();
        }
        if (visitorData['interview'] != null) {
          visitor.interviews = (visitorData['interview'] as List)
              .map((link) => Interview.fromJson(link))
              .toList();
        }
        if (visitorData['skill'] != null) {
          visitor.skills = (visitorData['skill'] as List)
              .map((link) => Skill.fromJson(link))
              .toList();
        }

        return visitor;
      }).toList();

      // Store the list of visitors in dataMgr
      dataMgr.visitors = visitors;

      return visitors;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
