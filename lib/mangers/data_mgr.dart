import 'package:q_flow_company/supabase/supabase_auth.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import '../model/user/company.dart';

class DataMgr {
  Company? company;

  final companyKey = 'company';

  DataMgr() {
    fetchData();
  }

  fetchData() async {
    await fetchCompanyData();
  }
  // Company Functions

  Future<void> fetchCompanyData() async {
    try {
      company = await SupabaseCompany.fetchCompany();
    } catch (_) {
      // Handle errors if necessary
    }
  }

  Future<void> saveCompanyData({required Company company}) async {
    this.company = company;
  }

  Future<void> logout() async {
    try {
      await SupabaseAuth.signOut();
      company = null;
    } catch (e) {
      print('Logout error: $e');
    }
  }
}
