class DuAnNhanVienModel {
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? tieuDe;
  String? diaChi;
  String? moTa;

  DuAnNhanVienModel({
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.tieuDe,
      this.diaChi,
      this.moTa
      });

  DuAnNhanVienModel.fromJson(Map<String, dynamic> json) {
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    tieuDe = json['tieuDe'].toString();
    diaChi = json['diaChi'].toString();
    moTa = json['moTa'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['tieuDe'] = tieuDe;
    data['diaChi'] = diaChi;
    data['moTa'] = moTa;
    return data;
  }
}
