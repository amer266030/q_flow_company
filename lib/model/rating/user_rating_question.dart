class UserRatingQuestion {
  String? id;
  String? title;
  String? text;
  int? sortOrder;

  UserRatingQuestion({this.id, this.title, this.text, this.sortOrder});

  factory UserRatingQuestion.fromJson(Map<String, dynamic> json) {
    return UserRatingQuestion(
      id: json['id'] as String?,
      title: json['title'] as String?,
      text: json['text'] as String?,
      sortOrder: json['sort_order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'sort_order': sortOrder,
    };
  }
}
