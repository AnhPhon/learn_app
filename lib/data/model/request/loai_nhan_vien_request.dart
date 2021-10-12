class LoaiNhanVienRequest {
  String? id;
  String? tieuDe;
  LoaiNhanVienRequest({
      this.id,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  LoaiNhanVienRequest.fromJson(Map<String, dynamic> json) {
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
