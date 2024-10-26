class UserQuestionRating {
  String? id;
  String? userRatingId; // Foreign key to the UserRating
  String? questionId; // Foreign key to UserRatingQuestion
  int? rating;

  UserQuestionRating({
    this.id,
    this.userRatingId,
    this.questionId,
    this.rating,
  });
}
