class ThongTinNganHangModel {
  String? tenNganHang;
  String? soTaiKhoan;
  String? tenChuTaiKhoan;

  ThongTinNganHangModel({
      this.tenNganHang,
      this.soTaiKhoan,
      this.tenChuTaiKhoan
      });

  ThongTinNganHangModel.fromJson(Map<String, dynamic> json) {
    tenNganHang = json['tenNganHang'].toString();
    soTaiKhoan = json['soTaiKhoan'].toString();
    tenChuTaiKhoan = json['tenChuTaiKhoan'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenNganHang'] = tenNganHang;
    data['soTaiKhoan'] = soTaiKhoan;
    data['tenChuTaiKhoan'] = tenChuTaiKhoan;
    return data;
  }
}
