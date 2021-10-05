class TinHocModel {
  String? idTaiKhoan;
  String? word;
  String? excel;
  String? internet;
  String? phanMemHoTro;
  String? soThichTrinhDo;
  String? soThichKyNang;
  String? soTichTinhCach;

  TinHocModel({
      this.idTaiKhoan,
      this.word,
      this.excel,
      this.internet,
      this.phanMemHoTro,
      this.soThichTrinhDo,
      this.soThichKyNang,
      this.soTichTinhCach
      });

  TinHocModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    word = json['word'].toString();
    excel = json['excel'].toString();
    internet = json['internet'].toString();
    phanMemHoTro = json['phanMemHoTro'].toString();
    soThichTrinhDo = json['soThichTrinhDo'].toString();
    soThichKyNang = json['soThichKyNang'].toString();
    soTichTinhCach = json['soTichTinhCach'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['word'] = word;
    data['excel'] = excel;
    data['internet'] = internet;
    data['phanMemHoTro'] = phanMemHoTro;
    data['soThichTrinhDo'] = soThichTrinhDo;
    data['soThichKyNang'] = soThichKyNang;
    data['soTichTinhCach'] = soTichTinhCach;
    return data;
  }
}
