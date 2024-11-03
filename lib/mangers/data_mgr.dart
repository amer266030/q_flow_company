import 'package:q_flow_company/model/user/visitor.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import 'package:q_flow_company/supabase/supabase_event.dart';
import '../model/event/event.dart';
import '../model/user/company.dart';
import '../supabase/supabase_visitor.dart';

class DataMgr {
  Company? company;
  List<Visitor> visitors = [];
  List<Event> events = [];

  DataMgr() {
    // fetchData();
  }

  fetchData() async {
    await _fetchCompanyData();
    await _fetchVisitorsData();
    await _fetchEvents();
  }
  // Company Functions

  Future<void> _fetchCompanyData() async {
    try {
      company = await SupabaseCompany.fetchCompany();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> saveCompanyData({required Company company}) async {
    this.company = company;
  }

  Future<void> _fetchVisitorsData() async {
    try {
      await SupabaseVisitor.fetchVisitors();
    } catch (e) {
      rethrow;
    }
  }

  Future _fetchEvents() async {
    try {
      events = await SupabaseEvent.fetchEvents() ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
