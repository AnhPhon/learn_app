class BangGiaDonHangRequest {
  String? id;
  String? tieuDe;
  String? giaTien;
  String? donViTinh;

  BangGiaDonHangRequest({
      this.id,
      this.tieuDe,
      this.giaTien,
      this.donViTinh});
  
  ///
  /// From JSON
  ///
  BangGiaDonHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    giaTien = json['giaTien'].toString();
    donViTinh = json['donViTinh'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null giaTien
    if (giaTien != null) data['giaTien'] = giaTien; 

    // check null donViTinh
    if (donViTinh != null) data['donViTinh'] = donViTinh; 


    return data;
  }
}
