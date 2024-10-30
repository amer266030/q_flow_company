import 'package:q_flow_company/model/user/visitor.dart';
import 'package:q_flow_company/supabase/supabase_auth.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import '../model/user/company.dart';
import '../supabase/supabase_visitor.dart';

class DataMgr {
  Company? company;
  List<Visitor> visitors = [];

  DataMgr() {
    // fetchData();
  }

  fetchData() async {
    await fetchCompanyData();
    await fetchVisitorsData();
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

  Future<void> fetchVisitorsData() async {
    try {
      await SupabaseVisitor.fetchVisitors();
    } catch (e) {
      // Handle errors if necessary
    }
  }

  Future<void> logout() async {
    try {
      await SupabaseAuth.signOut();
      company = null;
    } catch (e) {
      // Handle errors if necessary
    }
  }
}
