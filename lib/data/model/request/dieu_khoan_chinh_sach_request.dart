class DieuKhoanChinhSachRequest {
  String? id;
  String? type;
  String? tieuDe;
  String? noiDung;
  DieuKhoanChinhSachRequest({
      this.id,
      this.type,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  DieuKhoanChinhSachRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}
