import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mangers/data_mgr.dart';
import '../model/interview.dart';
import 'client/supabase_mgr.dart';

class SupabaseInterview {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'interview';
  static final dataMgr = GetIt.I.get<DataMgr>();

  static Stream<List<Interview>> interviewStream() {
    try {
      var companyId = supabase.auth.currentUser?.id;
      if (companyId == null) throw Exception("CompanyID".tr());

      return supabase
          .from(tableKey)
          .stream(primaryKey: ['id'])
          .eq('company_id', companyId)
          .order('created_at', ascending: false)
          .map((data) {
            return data.map((json) => Interview.fromJson(json)).toList();
          });
    } catch (e) {
      return const Stream<List<Interview>>.empty();
    }
  }

  static Future<List<Interview>> fetchInterviews() async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("CompanyID".tr());

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

  static Future updateInterview(Interview interview) async {
    try {
      if (interview.id == null) {
        throw Exception('Could not find an interview to update');
      }
      final response = await supabase
          .from(tableKey)
          .update(interview.toJson())
          .eq('id', interview.id!)
          .select()
          .single();

      return Interview.fromJson(response);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
