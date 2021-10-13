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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null moTa
    if (moTa != null) data['moTa'] = moTa; 


    return data;
  }
}
