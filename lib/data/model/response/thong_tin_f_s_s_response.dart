
class ThongTinFSSResponse {
  String? id;
  String? doiTuong;
  String? gioiThieuTomTatCoCheHoatDong;
  String? quyenNghiaVuFSS;
  String? quyTrinhSuDungGiaoDich;
  String? loiIchThamGiaFSS;

  ThongTinFSSResponse({
      this.id,
      this.doiTuong,
      this.gioiThieuTomTatCoCheHoatDong,
      this.quyenNghiaVuFSS,
      this.quyTrinhSuDungGiaoDich,
      this.loiIchThamGiaFSS});
  
  ///
  /// From JSON
  ///
  ThongTinFSSResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    doiTuong = json['doiTuong'].toString();
    gioiThieuTomTatCoCheHoatDong = json['gioiThieuTomTatCoCheHoatDong'].toString();
    quyenNghiaVuFSS = json['quyenNghiaVuFSS'].toString();
    quyTrinhSuDungGiaoDich = json['quyTrinhSuDungGiaoDich'].toString();
    loiIchThamGiaFSS = json['loiIchThamGiaFSS'].toString();

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


    return data;
  }
}
