class ThongTinFSSRequest {
  String? id;
  String? doiTuong;
  String? gioiThieuTomTatCoCheHoatDong;
  String? quyenNghiaVuFSS;
  String? quyTrinhSuDungGiaoDich;
  String? loiIchThamGiaFSS;
  ThongTinFSSRequest({
      this.id,
      this.doiTuong,
      this.gioiThieuTomTatCoCheHoatDong,
      this.quyenNghiaVuFSS,
      this.quyTrinhSuDungGiaoDich,
      this.loiIchThamGiaFSS});
  
  ///
  /// From JSON
  ///
  ThongTinFSSRequest.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['doiTuong'] = doiTuong;
    data['gioiThieuTomTatCoCheHoatDong'] = gioiThieuTomTatCoCheHoatDong;
    data['quyenNghiaVuFSS'] = quyenNghiaVuFSS;
    data['quyTrinhSuDungGiaoDich'] = quyTrinhSuDungGiaoDich;
    data['loiIchThamGiaFSS'] = loiIchThamGiaFSS;
    return data;
  }
}
