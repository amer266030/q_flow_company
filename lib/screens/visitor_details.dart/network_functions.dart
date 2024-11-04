import 'package:flutter/material.dart';
import 'package:q_flow_company/model/enums/interview_status.dart';
import 'package:q_flow_company/screens/visitor_details.dart/visitor_details_cubit.dart';
import 'package:q_flow_company/supabase/supabase_interview.dart';

import '../../model/interview.dart';
import '../../model/rating/visitor_question_rating.dart';
import '../../supabase/supabase_rating.dart';

extension NetworkFunctions on VisitorDetailsCubit {
  Future interviewCompleted(BuildContext context) async {
    try {
      emitLoading();
      await _createRating(context);
      if (context.mounted) {
        await _updateInterview(context, interview, InterviewStatus.completed);
      }
      emitUpdate();
      if (context.mounted) navigateBack(context);
    } catch (e) {
      emitError('Could not update interview!\n${e.toString()}');
    }
  }

  Future interviewCancelled(BuildContext context) async {
    try {
      emitLoading();
      await _updateInterview(context, interview, InterviewStatus.cancelled);
      if (context.mounted) {
        navigateBack(context);
      }
    } catch (e) {
      emitError('Could not update interview!\n${e.toString()}');
    }
  }

  Future _createRating(BuildContext context) async {
    try {
      if (visitor?.id == null) throw Exception('Could not load visitor');
      if (dataMgr.company?.id == null) {
        throw Exception('Could not load company');
      }

      List<VisitorQuestionRating> questionRatings = _setRatings();

      await SupabaseRating.createRating(
        dataMgr.company!.id!,
        visitor!.id!,
        questionRatings,
      );
    } catch (e) {
      rethrow;
    }
  }

  List<VisitorQuestionRating> _setRatings() {
    List<VisitorQuestionRating> questionRatings = [];

    for (int i = 0; i < questions.length; i++) {
      questionRatings.add(
        VisitorQuestionRating(
          questionId: questions[i].id,
          rating: ratings[i],
        ),
      );
    }

    return questionRatings;
  }

  Future _updateInterview(BuildContext context, Interview interview,
      InterviewStatus newStatus) async {
    try {
      var updatedInterview = interview;
      updatedInterview.status = newStatus;

      await SupabaseInterview.updateInterview(interview);
    } catch (e) {
      rethrow;
    }
  }
}
