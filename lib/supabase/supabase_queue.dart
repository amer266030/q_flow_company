import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mangers/data_mgr.dart';
import '../model/queue_entry.dart';
import 'client/supabase_mgr.dart';

class SupabaseQueue {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'queue';
  static final dataMgr = GetIt.I.get<DataMgr>();

  static StreamSubscription<List<Map<String, dynamic>>>? interviewSubscription;

  static Future<int?> getQueueLength(String companyId) async {
    try {
      final maxPosition = await supabase
          .from('queue')
          .select('position')
          .eq('company_id', companyId)
          .order('position', ascending: false)
          .limit(1)
          .single();

      final nextPosition = (maxPosition['position'] ?? 0) + 1;
      return nextPosition;
    } catch (e) {
      rethrow;
    }
  }

  // Insert And Delete

  static Future<QueueEntry> insertIntoQueue(QueueEntry queueEntry) async {
    try {
      final response =
          await supabase.from('queue').insert(queueEntry).select().single();
      return QueueEntry.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteFromQueue(QueueEntry queueEntry) async {
    if (queueEntry.interviewId == null) {
      throw Exception("Interview ID not found");
    }
    try {
      await supabase
          .from(tableKey)
          .delete()
          .eq('interview_id', queueEntry.interviewId!);
    } catch (e) {
      rethrow;
    }
  }

  // Single Stream

  static Stream<int> getQueueLengthStream(String companyId) {
    final stream = supabase
        .from(tableKey)
        .stream(primaryKey: ['id'])
        .eq('companyId', companyId)
        .map((event) {
          // Calculate queue length whenever an event is triggered
          return event.length;
        });

    print('event triggered');

    return stream;
  }

  // Multi-Stream

  static Stream<List<QueueEntry>> subscribeToMultipleUpdates({
    required List<String> interviewIds,
    required String companyId,
  }) {
    return supabase
        .from(tableKey)
        .stream(primaryKey: ['id'])
        .eq('company_id', companyId)
        .map((queueEntries) {
          return queueEntries
              .where((entry) => interviewIds.contains(entry['interview_id']))
              .map((entry) => QueueEntry.fromJson(entry))
              .toList();
        });
  }

  static void unsubscribeFromQueueUpdates() {
    interviewSubscription?.cancel();
    interviewSubscription = null;
  }
}
