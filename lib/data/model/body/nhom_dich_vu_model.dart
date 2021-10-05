class NhomDichVuModel {
  String? tenDichVu;

  NhomDichVuModel({
      this.tenDichVu
      });

  NhomDichVuModel.fromJson(Map<String, dynamic> json) {
    tenDichVu = json['tenDichVu'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenDichVu'] = tenDichVu;
    return data;
  }
}
