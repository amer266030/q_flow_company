import 'package:q_flow_company/model/enums/tech_skill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/skills/skill.dart';
import 'client/supabase_mgr.dart';

class SupabaseSkill {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'skill';

  static updateSkills(List<Skill> skills) async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId == null) throw Exception("Company ID not found");

    try {
      // Step 1: Delete existing skills for the company
      await supabase.from(tableKey).delete().eq('company_id', companyId);

      // Step 2: Insert the new selection of skills
      final skillsData = skills.map((skill) {
        skill.companyId = companyId;
        return skill.toJson();
      }).toList();

      var result = await supabase.from(tableKey).insert(skillsData).select();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
