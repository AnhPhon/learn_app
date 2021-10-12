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
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    data['giaTien'] = giaTien;
    data['donViTinh'] = donViTinh;
    return data;
  }
}
