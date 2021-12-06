class ImageUpdateModel {
  String? id;
  String? data;
  List<String>? files;

  ImageUpdateModel({this.id, this.data});

  ImageUpdateModel.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    data = json['data'].toString();
    if(json['files'] != null){
      files = (json['files'] as List<dynamic>).cast<String>().toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data'] = data;
    data['files'] = files;
    return data;
  }
}
