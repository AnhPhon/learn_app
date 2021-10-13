import 'tai_khoan_response.dart';

class KeKhaiKinhNghiemResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? donVi;
  String? chucVu;
  String? mucLuong;
  String? congViecPhuTrach;
  String? ketQua;

  String? createdAt;
  String? updatedAt;

  KeKhaiKinhNghiemResponse({
      this.id,
      this.idTaiKhoan,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.donVi,
      this.chucVu,
      this.mucLuong,
      this.congViecPhuTrach,
      this.ketQua,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  KeKhaiKinhNghiemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    thoiGianBatDau = json['thoiGianBatDau'].toString();
    thoiGianKetThuc = json['thoiGianKetThuc'].toString();
    donVi = json['donVi'].toString();
    chucVu = json['chucVu'].toString();
    mucLuong = json['mucLuong'].toString();
    congViecPhuTrach = json['congViecPhuTrach'].toString();
    ketQua = json['ketQua'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null thoiGianBatDau
    if (thoiGianBatDau != null) data['thoiGianBatDau'] = thoiGianBatDau; 

    // check null thoiGianKetThuc
    if (thoiGianKetThuc != null) data['thoiGianKetThuc'] = thoiGianKetThuc; 

    // check null donVi
    if (donVi != null) data['donVi'] = donVi; 

    // check null chucVu
    if (chucVu != null) data['chucVu'] = chucVu; 

    // check null mucLuong
    if (mucLuong != null) data['mucLuong'] = mucLuong; 

    // check null congViecPhuTrach
    if (congViecPhuTrach != null) data['congViecPhuTrach'] = congViecPhuTrach; 

    // check null ketQua
    if (ketQua != null) data['ketQua'] = ketQua; 


    return data;
  }
}