class ThongTinFSSModel {
  String? doiTuong;
  String? gioiThieuTomTatCoCheHoatDong;
  String? quyenNghiaVuFSS;
  String? quyTrinhSuDungGiaoDich;
  String? loiIchThamGiaFSS;

  ThongTinFSSModel({
      this.doiTuong,
      this.gioiThieuTomTatCoCheHoatDong,
      this.quyenNghiaVuFSS,
      this.quyTrinhSuDungGiaoDich,
      this.loiIchThamGiaFSS
      });

  ThongTinFSSModel.fromJson(Map<String, dynamic> json) {
    doiTuong = json['doiTuong'].toString();
    gioiThieuTomTatCoCheHoatDong = json['gioiThieuTomTatCoCheHoatDong'].toString();
    quyenNghiaVuFSS = json['quyenNghiaVuFSS'].toString();
    quyTrinhSuDungGiaoDich = json['quyTrinhSuDungGiaoDich'].toString();
    loiIchThamGiaFSS = json['loiIchThamGiaFSS'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doiTuong'] = doiTuong;
    data['gioiThieuTomTatCoCheHoatDong'] = gioiThieuTomTatCoCheHoatDong;
    data['quyenNghiaVuFSS'] = quyenNghiaVuFSS;
    data['quyTrinhSuDungGiaoDich'] = quyTrinhSuDungGiaoDich;
    data['loiIchThamGiaFSS'] = loiIchThamGiaFSS;
    return data;
  }
}
