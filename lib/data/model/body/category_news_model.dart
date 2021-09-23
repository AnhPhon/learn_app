class CategoryNewsModel {
  String? name;
  String? slug;

  CategoryNewsModel({
      this.name,
      this.slug
      });

  CategoryNewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    slug = json['slug'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}
