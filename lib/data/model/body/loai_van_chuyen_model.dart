class LoaiVanChuyenModel {
  String? idTaiKhoan;
  String? tieuDe;

  LoaiVanChuyenModel({
      this.idTaiKhoan,
      this.tieuDe
      });

  LoaiVanChuyenModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
