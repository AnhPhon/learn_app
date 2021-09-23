class CategoryModel {
  String? name;
  String? desciption;
  String? thumbnail;
  String? shortcut;

  CategoryModel({
      this.name,
      this.desciption,
      this.thumbnail,
      this.shortcut
      });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    desciption = json['desciption'].toString();
    thumbnail = json['thumbnail'].toString();
    shortcut = json['shortcut'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['desciption'] = desciption;
    data['thumbnail'] = thumbnail;
    data['shortcut'] = shortcut;
    return data;
  }
}
