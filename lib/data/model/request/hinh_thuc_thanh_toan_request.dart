class HinhThucThanhToanRequest {
  String? id;
  String? tieuDe;
  String? noiDung;
  HinhThucThanhToanRequest({
      this.id,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  HinhThucThanhToanRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}
