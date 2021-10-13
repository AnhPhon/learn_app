class LoaiCongViecRequest {
  String? id;
  String? idNhomDichVu;
  String? tenCongViec;

  LoaiCongViecRequest({
      this.id,
      this.idNhomDichVu,
      this.tenCongViec});
  
  ///
  /// From JSON
  ///
  LoaiCongViecRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    tenCongViec = json['tenCongViec'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu; 

    // check null tenCongViec
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec; 


    return data;
  }
}
