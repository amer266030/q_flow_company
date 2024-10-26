class CompanyQuestionRating {
  String? id;
  String? companyRatingId; // Foreign key to the CompanyRating
  String? questionId; // Foreign key to CompanyRatingQuestion
  int? rating;

  CompanyQuestionRating({
    this.id,
    this.companyRatingId,
    this.questionId,
    this.rating,
  });
}
