class DistrictModel {
  String? idProvince;
  String? name;
  String? type;

  DistrictModel({
      this.idProvince,
      this.name,
      this.type
      });

  DistrictModel.fromJson(Map<String, dynamic> json) {
    idProvince = json['idProvince'].toString();
    name = json['name'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProvince'] = idProvince;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
