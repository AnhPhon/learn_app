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
    // check null id
    if (id != null) data['id'] = id; 

    // check null tenNganHang
    if (tenNganHang != null) data['tenNganHang'] = tenNganHang; 

    // check null soTaiKhoan
    if (soTaiKhoan != null) data['soTaiKhoan'] = soTaiKhoan; 

    // check null tenChuTaiKhoan
    if (tenChuTaiKhoan != null) data['tenChuTaiKhoan'] = tenChuTaiKhoan; 


    return data;
  }
}
