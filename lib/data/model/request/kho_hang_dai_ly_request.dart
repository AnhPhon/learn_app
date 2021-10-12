class KhoHangDaiLyRequest {
  String? id;
  String? idTaiKhoan;
  String? ten;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? diaChi;
  String? idSanPham;
  String? soluong;
  KhoHangDaiLyRequest({
      this.id,
      this.idTaiKhoan,
      this.ten,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.idSanPham,
      this.soluong});
  
  ///
  /// From JSON
  ///
  KhoHangDaiLyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    ten = json['ten'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    diaChi = json['diaChi'].toString();
    idSanPham = json['idSanPham'].toString();
    soluong = json['soluong'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['ten'] = ten;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['diaChi'] = diaChi;
    data['idSanPham'] = idSanPham;
    data['soluong'] = soluong;
    return data;
  }
}
