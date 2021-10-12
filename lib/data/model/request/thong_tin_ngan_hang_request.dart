class ThongTinNganHangRequest {
  String? id;
  String? tenNganHang;
  String? soTaiKhoan;
  String? tenChuTaiKhoan;
  ThongTinNganHangRequest({
      this.id,
      this.tenNganHang,
      this.soTaiKhoan,
      this.tenChuTaiKhoan});
  
  ///
  /// From JSON
  ///
  ThongTinNganHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenNganHang = json['tenNganHang'].toString();
    soTaiKhoan = json['soTaiKhoan'].toString();
    tenChuTaiKhoan = json['tenChuTaiKhoan'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenNganHang'] = tenNganHang;
    data['soTaiKhoan'] = soTaiKhoan;
    data['tenChuTaiKhoan'] = tenChuTaiKhoan;
    return data;
  }
}
