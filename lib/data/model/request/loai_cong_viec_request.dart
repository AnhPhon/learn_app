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
    data['id'] = id;
    data['idNhomDichVu'] = idNhomDichVu;
    data['tenCongViec'] = tenCongViec;
    return data;
  }
}
