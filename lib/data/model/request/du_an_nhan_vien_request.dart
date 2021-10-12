class DuAnNhanVienRequest {
  String? id;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? tieuDe;
  String? diaChi;
  String? moTa;
  DuAnNhanVienRequest({
      this.id,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.tieuDe,
      this.diaChi,
      this.moTa});
  
  ///
  /// From JSON
  ///
  DuAnNhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    tieuDe = json['tieuDe'].toString();
    diaChi = json['diaChi'].toString();
    moTa = json['moTa'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['tieuDe'] = tieuDe;
    data['diaChi'] = diaChi;
    data['moTa'] = moTa;
    return data;
  }
}
