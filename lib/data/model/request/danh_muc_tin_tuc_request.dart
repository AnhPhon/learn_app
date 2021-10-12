class DanhMucTinTucRequest {
  String? id;
  String? tieuDe;
  DanhMucTinTucRequest({
      this.id,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  DanhMucTinTucRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
