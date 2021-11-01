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
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 


    return data;
  }
}
