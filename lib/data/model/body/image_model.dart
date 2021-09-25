class ImageUpdateModel {
  String? id;
  String? url;

  ImageUpdateModel({this.id, this.url});

  ImageUpdateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    url = json['image'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = url;
    return data;
  }
}
