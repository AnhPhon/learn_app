
class ThongTinFSSResponse {
  String? id;
  String? doiTuong;
  String? gioiThieuTomTatCoCheHoatDong;
  String? quyenNghiaVuFSS;
  String? quyTrinhSuDungGiaoDich;
  String? loiIchThamGiaFSS;
  String? chiTietBaoHiem;
  String? hoTro;

  String? createdAt;
  String? updatedAt;

  ThongTinFSSResponse({
      this.id,
      this.doiTuong,
      this.gioiThieuTomTatCoCheHoatDong,
      this.quyenNghiaVuFSS,
      this.quyTrinhSuDungGiaoDich,
      this.loiIchThamGiaFSS,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongTinFSSResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    doiTuong = json['doiTuong'].toString();
    gioiThieuTomTatCoCheHoatDong = json['gioiThieuTomTatCoCheHoatDong'].toString();
    quyenNghiaVuFSS = json['quyenNghiaVuFSS'].toString();
    quyTrinhSuDungGiaoDich = json['quyTrinhSuDungGiaoDich'].toString();
    loiIchThamGiaFSS = json['loiIchThamGiaFSS'].toString();
    chiTietBaoHiem = json['chiTietBaoHiem'].toString();
    hoTro = json['hoTro'].toString();

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

    // check null doiTuong
    if (doiTuong != null) data['doiTuong'] = doiTuong; 

    // check null gioiThieuTomTatCoCheHoatDong
    if (gioiThieuTomTatCoCheHoatDong != null) data['gioiThieuTomTatCoCheHoatDong'] = gioiThieuTomTatCoCheHoatDong; 

    // check null quyenNghiaVuFSS
    if (quyenNghiaVuFSS != null) data['quyenNghiaVuFSS'] = quyenNghiaVuFSS; 

    // check null quyTrinhSuDungGiaoDich
    if (quyTrinhSuDungGiaoDich != null) data['quyTrinhSuDungGiaoDich'] = quyTrinhSuDungGiaoDich; 

    // check null loiIchThamGiaFSS
    if (loiIchThamGiaFSS != null) data['loiIchThamGiaFSS'] = loiIchThamGiaFSS; 

    // check null chiTietBaoHiem
    if (chiTietBaoHiem != null) data['chiTietBaoHiem'] = chiTietBaoHiem; 

    // check null hoTro
    if (hoTro != null) data['hoTro'] = hoTro; 


    return data;
  }
}
