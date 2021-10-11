import 'don_dich_vu_model.dart';

class DanhSachBaoGiaDonDichVuModel {
  DonDichVuModel? idDonDichVu;
  String? taiKhoanBaoGia;
  String? giaBao;
  String? ghiChu;
  String? file;
  String? daXem;

  DanhSachBaoGiaDonDichVuModel({
      this.idDonDichVu,
      this.taiKhoanBaoGia,
      this.giaBao,
      this.ghiChu,
      this.file,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuModel.fromJson(Map<String, dynamic> json) {

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null) {                                                  
      idDonDichVu = DonDichVuModel.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    file = json['file'].toString();
    daXem = json['daXem'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonDichVu'] = idDonDichVu;
    data['taiKhoanBaoGia'] = taiKhoanBaoGia;
    data['giaBao'] = giaBao;
    data['ghiChu'] = ghiChu;
    data['file'] = file;
    data['daXem'] = daXem;
    return data;
  }
}
