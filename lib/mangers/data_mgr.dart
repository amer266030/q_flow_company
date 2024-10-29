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
      await SupabaseCompany.fetchCompany();
    } catch (_) {}
  }

  Future<void> saveCompanyData({required Company company}) async {
    this.company = company;
  }
}
