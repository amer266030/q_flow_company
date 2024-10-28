import 'package:flutter/foundation.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseMgr {
  late final SupabaseClient supabase;
  User? currentUser;
  Company? currentCompany;

  SupabaseMgr._privateConstructor();

  static final SupabaseMgr _instance = SupabaseMgr._privateConstructor();

  static SupabaseMgr get shared => _instance;
  Future setCurrentUser()async{
    try{
      currentUser =supabase.auth.currentUser;
      if (currentUser != null){
      }
    }catch (e) {
      if (kDebugMode) {
        print('Error in setCurrentUser: $e');
      }
    }
  }

  // Initialize method to configure the Supabase client asynchronously
  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    supabase = await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"]!,
      anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
    ).then((value) => value.client);
    currentUser = supabase.auth.currentUser;
  }
}
