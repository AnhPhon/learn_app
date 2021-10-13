
class ThongTinNganHangResponse {
  String? id;
  String? tenNganHang;
  String? soTaiKhoan;
  String? tenChuTaiKhoan;

  String? createdAt;
  String? updatedAt;

  ThongTinNganHangResponse({
      this.id,
      this.tenNganHang,
      this.soTaiKhoan,
      this.tenChuTaiKhoan,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongTinNganHangResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenNganHang = json['tenNganHang'].toString();
    soTaiKhoan = json['soTaiKhoan'].toString();
    tenChuTaiKhoan = json['tenChuTaiKhoan'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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