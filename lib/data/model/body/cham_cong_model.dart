class ChamCongModel {
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

  ChamCongModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.noiDungBaoCao,
      this.viTri
      });

  ChamCongModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['thoiGianBatDau'] = thoiGianBatDau;
    data['thoiGianKetThuc'] = thoiGianKetThuc;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['diaChi'] = diaChi;
    data['noiDungBaoCao'] = noiDungBaoCao;
    data['viTri'] = viTri;
    return data;
  }
}