class ProvinceModel {
  String? name;
  String? type;

  ProvinceModel({
      this.name,
      this.type
      });

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
