class KeKhaiKinhNghiemModel {
  String? idTaiKhoan;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? donVi;
  String? chucVu;
  String? mucLuong;
  String? congViecPhuTrach;
  String? ketQua;

  KeKhaiKinhNghiemModel({
      this.idTaiKhoan,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.donVi,
      this.chucVu,
      this.mucLuong,
      this.congViecPhuTrach,
      this.ketQua
      });

  KeKhaiKinhNghiemModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    thoiGianBatDau = json['thoiGianBatDau'].toString();
    thoiGianKetThuc = json['thoiGianKetThuc'].toString();
    donVi = json['donVi'].toString();
    chucVu = json['chucVu'].toString();
    mucLuong = json['mucLuong'].toString();
    congViecPhuTrach = json['congViecPhuTrach'].toString();
    ketQua = json['ketQua'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['thoiGianBatDau'] = thoiGianBatDau;
    data['thoiGianKetThuc'] = thoiGianKetThuc;
    data['donVi'] = donVi;
    data['chucVu'] = chucVu;
    data['mucLuong'] = mucLuong;
    data['congViecPhuTrach'] = congViecPhuTrach;
    data['ketQua'] = ketQua;
    return data;
  }
}
