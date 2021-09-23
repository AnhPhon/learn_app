class NewsModel {
  String? name;
  String? image;
  String? body;
  String? tags;
  String? endAt;
  String? idCategoryNews;

  NewsModel({
      this.name,
      this.image,
      this.body,
      this.tags,
      this.endAt,
      this.idCategoryNews
      });

  NewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    image = json['image'].toString();
    body = json['body'].toString();
    tags = json['tags'].toString();
    endAt = json['endAt'].toString();
    idCategoryNews = json['idCategoryNews'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['body'] = body;
    data['tags'] = tags;
    data['endAt'] = endAt;
    data['idCategoryNews'] = idCategoryNews;
    return data;
  }
}
