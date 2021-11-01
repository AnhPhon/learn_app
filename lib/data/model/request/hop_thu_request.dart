class HopThuRequest {
  String? id;
  String? hoTen;
  String? noiDungTuVan;
  String? sdt;

  HopThuRequest({
      this.id,
      this.hoTen,
      this.noiDungTuVan,
      this.sdt});
  
  ///
  /// From JSON
  ///
  HopThuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    hoTen = json['hoTen'].toString();
    noiDungTuVan = json['noiDungTuVan'].toString();
    sdt = json['sdt'].toString();
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
