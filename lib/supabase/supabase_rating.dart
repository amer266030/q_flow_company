import 'package:easy_localization/easy_localization.dart';
import 'package:q_flow_company/model/rating/visitor_question_rating.dart';
import 'package:q_flow_company/model/rating/visitor_rating_question.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseRating {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String ratingTableKey = 'visitor_rating';
  static const String questionRatingTableKey = 'visitor_question_rating';
  static const String questionsTableKey = 'visitor_rating_question';

  static Future<List<VisitorRatingQuestion>>? fetchQuestions() async {
    try {
      var res = await supabase
          .from(questionsTableKey)
          .select()
          .order('sort_order', ascending: true);

      List<VisitorRatingQuestion> questions = (res as List)
          .map((event) =>
              VisitorRatingQuestion.fromJson(event as Map<String, dynamic>))
          .toList();

      return questions;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<double> fetchAvgRating(String visitorId) async {
    try {
      // Fetch all question ratings associated with the specified company
      final res = await supabase
          .from(questionRatingTableKey)
          .select('rating')
          .eq('visitor_id', visitorId);

      // Parse the response and calculate the average rating
      if (res.isNotEmpty) {
        List<int> ratings = res.map((item) => item['rating'] as int).toList();
        double avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
        return avgRating;
      } else {
        return 0.0;
      }
    } on PostgrestException catch (e) {
      throw Exception("FailedToFetch ${e.message}".tr());
    }
  }

  static Future<void> createRating(
    String companyId,
    String visitorId,
    List<VisitorQuestionRating> questionRatings,
  ) async {
    try {
      // Step 1: Insert the main rating entry for the company
      final ratingRes = await supabase
          .from(ratingTableKey)
          .insert({
            'company_id': companyId,
            'visitor_id': visitorId,
          })
          .select()
          .single();

      // Parse the new CompanyRating ID
      final visitorRatingId = ratingRes['id'] as String;

      // Step 2: Insert each question rating linked to the main rating
      final questionRatingData = questionRatings.map((questionRating) {
        return {
          'visitor_rating_id': visitorRatingId,
          'question_id': questionRating.questionId,
          'rating': questionRating.rating,
        };
      }).toList();

      await supabase.from(questionRatingTableKey).insert(questionRatingData);
    } on PostgrestException catch (e) {
      throw Exception("FailedToCreate ${e.message}".tr());
    }
  }
}
