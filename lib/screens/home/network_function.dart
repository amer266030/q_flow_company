import 'package:q_flow_company/screens/home/home_cubit.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';

extension NetworkFunctions on HomeCubit {
  Future fetchCompanyDetails() async {
    try {
      emitLoading();
      var companies = await SupabaseCompany.fetchCompany();
      return companies;
    } catch (e) {
      print("Error loading company details: $e");
    }
  }
}
