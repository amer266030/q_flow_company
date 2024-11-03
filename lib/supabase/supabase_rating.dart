import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/rating/company_question_rating.dart';
import '../model/rating/company_rating_question.dart';
import 'client/supabase_mgr.dart';

class SupabaseRating {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String ratingTableKey = 'company_rating';
  static const String questionRatingTableKey = 'company_question_rating';
  static const String questionsTableKey = 'company_rating_question';

  static Future<List<CompanyRatingQuestion>>? fetchQuestions() async {
    try {
      var res = await supabase
          .from(questionsTableKey)
          .select()
          .order('sort_order', ascending: true);

      List<CompanyRatingQuestion> questions = (res as List)
          .map((event) =>
              CompanyRatingQuestion.fromJson(event as Map<String, dynamic>))
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

  static Future<double> fetchAvgRating(String companyId) async {
    try {
      // Fetch all question ratings associated with the specified company
      final res = await supabase
          .from(questionRatingTableKey)
          .select('rating')
          .eq('company_id', companyId);

      // Parse the response and calculate the average rating
      if (res.isNotEmpty) {
        List<int> ratings = res.map((item) => item['rating'] as int).toList();
        double avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
        return avgRating;
      } else {
        return 0.0;
      }
    } on PostgrestException catch (e) {
      throw Exception("Failed to fetch average rating: ${e.message}");
    }
  }

  static Future<void> createRating(
    String companyId,
    String visitorId,
    List<CompanyQuestionRating> questionRatings,
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
      final companyRatingId = ratingRes['id'] as String;

      // Step 2: Insert each question rating linked to the main rating
      final questionRatingData = questionRatings.map((questionRating) {
        return {
          'company_rating_id': companyRatingId,
          'question_id': questionRating.questionId,
          'rating': questionRating.rating,
        };
      }).toList();

      await supabase.from(questionRatingTableKey).insert(questionRatingData);
    } on PostgrestException catch (e) {
      throw Exception("Failed to create rating: ${e.message}");
    }
  }
}
