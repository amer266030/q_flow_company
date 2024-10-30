import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const invitationTableKey = 'event_invited_user';

  static Future sendOTP(String email) async {
    try {
      final invitationCheck = await supabase
          .from(invitationTableKey)
          .select('is_company')
          .eq('email', email)
          .maybeSingle();

      if (invitationCheck == null) {
        throw Exception(
            "The provided email haven't been invited to an event. Please contact the organizer for support");
      } else if (invitationCheck['is_company'] == false) {
        throw Exception(
            "Access Denied!\nProvided email is intended for our Visitor App");
      }
      var response = await supabase.auth.signInWithOtp(email: email);
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future verifyOTP(
    String email,
    String otp,
  ) async {
    try {
      final response = await supabase.auth
          .verifyOTP(email: email, type: OtpType.email, token: otp);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future signOut() async {
    try {
      var response = await supabase.auth.signOut();

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
