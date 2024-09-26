class FreeFakePostModel {
  final int? id;
  final String? title;
  final String? content;
  final String? picture;

  const FreeFakePostModel({
    this.id,
    this.title,
    this.content,
    this.picture,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "picture": picture,
  };

  factory FreeFakePostModel.fromJson(Map<String, dynamic> json) {
    return FreeFakePostModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      picture: json["picture"],
    );

  }
//
}
