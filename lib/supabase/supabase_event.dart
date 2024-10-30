import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/event/event.dart';
import 'client/supabase_mgr.dart';

class SupabaseEvent {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String eventTableKey = 'event';

  static Future<List<Event>>? fetchEvents() async {
    try {
      var res = await supabase.from(eventTableKey).select();
      List<Event> events = (res as List)
          .map((event) => Event.fromJson(event as Map<String, dynamic>))
          .toList();
      print(events.length);
      return events;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
