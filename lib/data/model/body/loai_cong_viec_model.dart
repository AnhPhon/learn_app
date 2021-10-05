class LoaiCongViecModel {
  String? idNhomDichVu;
  String? tenCongViec;

  LoaiCongViecModel({
      this.idNhomDichVu,
      this.tenCongViec
      });

  LoaiCongViecModel.fromJson(Map<String, dynamic> json) {
    idNhomDichVu = json['idNhomDichVu'].toString();
    tenCongViec = json['tenCongViec'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhomDichVu'] = idNhomDichVu;
    data['tenCongViec'] = tenCongViec;
    return data;
  }
}
