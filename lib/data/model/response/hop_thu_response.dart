
class HopThuResponse {
  String? id;
  String? hoTen;
  String? noiDungTuVan;
  String? sdt;

  String? createdAt;
  String? updatedAt;

  HopThuResponse({
      this.id,
      this.hoTen,
      this.noiDungTuVan,
      this.sdt,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  HopThuResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    hoTen = json['hoTen'].toString();
    noiDungTuVan = json['noiDungTuVan'].toString();
    sdt = json['sdt'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null hoTen
    if (hoTen != null) data['hoTen'] = hoTen; 

    // check null noiDungTuVan
    if (noiDungTuVan != null) data['noiDungTuVan'] = noiDungTuVan; 

    // check null sdt
    if (sdt != null) data['sdt'] = sdt; 


    return data;
  }
}
