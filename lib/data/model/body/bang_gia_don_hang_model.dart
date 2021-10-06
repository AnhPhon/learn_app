class BangGiaDonHangModel {
  String? tieuDe;
  String? giaTien;
  String? donViTinh;

  BangGiaDonHangModel({
      this.tieuDe,
      this.giaTien,
      this.donViTinh
      });

  BangGiaDonHangModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    giaTien = json['giaTien'].toString();
    donViTinh = json['donViTinh'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    data['giaTien'] = giaTien;
    data['donViTinh'] = donViTinh;
    return data;
  }
}