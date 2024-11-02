import 'package:flutter/cupertino.dart';
import 'package:q_flow_company/screens/position_opening/position_opening_cubit.dart';
import 'package:q_flow_company/supabase/supabase_skill.dart';

import '../../model/skills/skill.dart';

extension NetworkFunctions on PositionOpeningCubit {
  // Use for both insert and update
  Future updateSkills(BuildContext context) async {
    try {
      emitLoading();
      var techSkills = createSkills();
      await SupabaseSkill.updateSkills(techSkills);
      dataMgr.company?.skills = techSkills;

      if (context.mounted) navigateToHome(context);
    } catch (e) {
      emitError("Error loading company details: $e");
    }
  }

  List<Skill> createSkills() {
    return positions
        .map((position) =>
            Skill(companyId: dataMgr.company?.id, techSkill: position))
        .toList();
  }
}
