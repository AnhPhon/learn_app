
class ThongTinNganHangModel {
  String? tenNganHang;
  String? soTaiKhoan;
  String? tenChuTaiKhoan;

  ThongTinNganHangModel({
      this.tenNganHang,
      this.soTaiKhoan,
      this.tenChuTaiKhoan});
  
  ///
  /// From JSON
  ///
  ThongTinNganHangModel.fromJson(Map<String, dynamic> json) {
    tenNganHang = json['tenNganHang'].toString();
    soTaiKhoan = json['soTaiKhoan'].toString();
    tenChuTaiKhoan = json['tenChuTaiKhoan'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tenNganHang
    if (tenNganHang != null) data['tenNganHang'] = tenNganHang; 

    // check null soTaiKhoan
    if (soTaiKhoan != null) data['soTaiKhoan'] = soTaiKhoan; 

    // check null tenChuTaiKhoan
    if (tenChuTaiKhoan != null) data['tenChuTaiKhoan'] = tenChuTaiKhoan; 


    return data;
  }
}
