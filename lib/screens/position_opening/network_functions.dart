import 'package:q_flow_company/screens/position_opening/position_opening_cubit.dart';

extension NetworkFunctions on PositionOpeningCubit {
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
