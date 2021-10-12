class LoaiVanChuyenRequest {
  String? id;
  String? idTaiKhoan;
  String? tieuDe;
  LoaiVanChuyenRequest({
      this.id,
      this.idTaiKhoan,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  LoaiVanChuyenRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
