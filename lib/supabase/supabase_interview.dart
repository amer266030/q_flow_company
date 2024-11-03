import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mangers/data_mgr.dart';
import '../model/interview.dart';
import 'client/supabase_mgr.dart';

class SupabaseInterview {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'interview';
  static final dataMgr = GetIt.I.get<DataMgr>();

  static Future<List<Interview>> fetchInterviews() async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("Company ID not found");

    try {
      final response = await supabase
          .from(tableKey)
          .select()
          .eq('company_id', companyId)
          .order('created_at', ascending: false);

      return response.map((json) => Interview.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String>> fetchScheduledInterviewIds(
      String companyId) async {
    final response = await SupabaseMgr.shared.supabase
        .from(tableKey)
        .select('id')
        .eq('company_id', companyId)
        .eq('status', 'Upcoming');

    return (response as List)
        .map((interview) => interview['id'] as String)
        .toList();
  }
}
