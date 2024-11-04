class VisitorQuestionRating {
  String? id;
  String? visitorRatingId; // Foreign key to the CompanyRating
  String? questionId; // Foreign key to CompanyRatingQuestion
  int? rating;

  VisitorQuestionRating({
    this.id,
    this.visitorRatingId,
    this.questionId,
    this.rating,
  });

  // Factory method to create an instance from JSON
  factory VisitorQuestionRating.fromJson(Map<String, dynamic> json) {
    return VisitorQuestionRating(
      id: json['id'] as String?,
      visitorRatingId: json['visitor_rating_id'] as String?,
      questionId: json['question_id'] as String?,
      rating: json['rating'] as int?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'visitor_rating_id': visitorRatingId,
      'question_id': questionId,
      'rating': rating,
    };
  }
}
