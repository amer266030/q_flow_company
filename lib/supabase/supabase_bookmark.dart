import 'package:easy_localization/easy_localization.dart';
import 'package:q_flow_company/model/bookmarks/bookmarked_visitor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseBookmark {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'bookmarked_visitor';

  static Future<List<BookmarkedVisitor>> fetchBookmarks() async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

    var response =
        await supabase.from(tableKey).select().eq('company_id', companyId);
    return response.map((json) => BookmarkedVisitor.fromJson(json)).toList();
  }

  static Future<BookmarkedVisitor> createBookmark(String visitorId) async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

    try {
      // Create a new bookmarked company instance
      var bookmark =
          BookmarkedVisitor(visitorId: visitorId, companyId: companyId);
      var response = await supabase
          .from(tableKey)
          .insert(bookmark.toJson())
          .select()
          .single();

      return BookmarkedVisitor.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteBookmark(String visitorId) async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

    try {
      await supabase
          .from(tableKey)
          .delete()
          .eq('visitor_id', visitorId)
          .eq('company_id', companyId);
    } catch (e) {
      rethrow;
    }
  }
}
