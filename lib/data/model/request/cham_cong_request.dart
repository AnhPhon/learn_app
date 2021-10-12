class ChamCongRequest {
  String? id;
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? diaChi;
  String? noiDungBaoCao;
  String? viTri;

  ChamCongRequest({
      this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.noiDungBaoCao,
      this.viTri});
  
  ///
  /// From JSON
  ///
  ChamCongRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    thoiGianBatDau = json['thoiGianBatDau'].toString();
    thoiGianKetThuc = json['thoiGianKetThuc'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    diaChi = json['diaChi'].toString();
    noiDungBaoCao = json['noiDungBaoCao'].toString();
    viTri = json['viTri'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null thoiGianBatDau
    if (thoiGianBatDau != null) data['thoiGianBatDau'] = thoiGianBatDau; 

    // check null thoiGianKetThuc
    if (thoiGianKetThuc != null) data['thoiGianKetThuc'] = thoiGianKetThuc; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null noiDungBaoCao
    if (noiDungBaoCao != null) data['noiDungBaoCao'] = noiDungBaoCao; 

    // check null viTri
    if (viTri != null) data['viTri'] = viTri; 


    return data;
  }
}
