class UserQuestionRating {
  String? id;
  String? companyRatingId; // Foreign key to the CompanyRating
  String? questionId; // Foreign key to CompanyRatingQuestion
  int? rating;

  UserQuestionRating({
    this.id,
    this.companyRatingId,
    this.questionId,
    this.rating,
  });

  // Factory method to create an instance from JSON
  factory UserQuestionRating.fromJson(Map<String, dynamic> json) {
    return UserQuestionRating(
      id: json['id'] as String?,
      companyRatingId: json['company_rating_id'] as String?,
      questionId: json['question_id'] as String?,
      rating: json['rating'] as int?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'company_rating_id': companyRatingId,
      'question_id': questionId,
      'rating': rating,
    };
  }
}
