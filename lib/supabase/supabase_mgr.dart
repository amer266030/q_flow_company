import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMgr {
  late final SupabaseClient supabase;

  SupabaseMgr._privateConstructor();

  static final SupabaseMgr _instance = SupabaseMgr._privateConstructor();

  static SupabaseMgr get shared => _instance;

  // Initialize method to configure the Supabase client asynchronously
  Future<void> initialize() async {
    supabase = await Supabase.initialize(
      url: '',
      anonKey: '',
    ).then((value) => value.client);
  }
}
