import 'package:q_flow_company/supabase/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  static Future sendOTP(String email) async {
    try {
      // final profileCheck = await supabase
      //     .from('profile')
      //     .select('id, role')
      //     .eq('email', email)
      //     .single();
      // if (profileCheck['role'] != 'company') {
      //   throw Exception(
      //       "Access denied. User must have an organizer profile to sign in.");
      // }

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
      print('Error verifying OTP: $e');
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
