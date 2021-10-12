class NhomDichVuRequest {
  String? id;
  String? tenDichVu;
  NhomDichVuRequest({
      this.id,
      this.tenDichVu});
  
  ///
  /// From JSON
  ///
  NhomDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenDichVu = json['tenDichVu'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenDichVu'] = tenDichVu;
    return data;
  }
}
