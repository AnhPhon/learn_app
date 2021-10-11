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
    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null taiKhoanBaoGia
    if (taiKhoanBaoGia != null) data['taiKhoanBaoGia'] = taiKhoanBaoGia; 

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao; 

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
