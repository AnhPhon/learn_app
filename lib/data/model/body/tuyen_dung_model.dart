class TuyenDungModel {
  String? idTaiKhoan;
  String? tieuDe;
  String? congTy;
  String? diaChi;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? gioiTinh;
  String? soLuong;
  String? idHinhThucLamViec;
  String? idTrinhDoHocVan;
  String? idChuyenNganhChinh;
  String? idSoNamKinhNghiem;
  String? idMucLuongDuKien;
  String? noiLamViec;
  String? idThoiGianLamViec;
  String? moTaCongViec;
  String? yeuCauCongViec;
  String? quyenLoi;
  String? uuTien;
  String? hanNopHoSo;
  String? hoTenLienHe;
  String? soDienThoaiLienHe;
  String? diaChiLienHe;
  String? emailLienHe;
  String? idBangGiaDangTin;
  String? idBangGiaLocHoSo;
  String? idHinhThucThanhToan;
  String? idTrangThaiDonHang;
  String? khuyenMai;
  String? soTien;
  String? tongDon;

  TuyenDungModel({
      this.idTaiKhoan,
      this.tieuDe,
      this.congTy,
      this.diaChi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.gioiTinh,
      this.soLuong,
      this.idHinhThucLamViec,
      this.idTrinhDoHocVan,
      this.idChuyenNganhChinh,
      this.idSoNamKinhNghiem,
      this.idMucLuongDuKien,
      this.noiLamViec,
      this.idThoiGianLamViec,
      this.moTaCongViec,
      this.yeuCauCongViec,
      this.quyenLoi,
      this.uuTien,
      this.hanNopHoSo,
      this.hoTenLienHe,
      this.soDienThoaiLienHe,
      this.diaChiLienHe,
      this.emailLienHe,
      this.idBangGiaDangTin,
      this.idBangGiaLocHoSo,
      this.idHinhThucThanhToan,
      this.idTrangThaiDonHang,
      this.khuyenMai,
      this.soTien,
      this.tongDon
      });

  TuyenDungModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
    congTy = json['congTy'].toString();
    diaChi = json['diaChi'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    gioiTinh = json['gioiTinh'].toString();
    soLuong = json['soLuong'].toString();
    idHinhThucLamViec = json['idHinhThucLamViec'].toString();
    idTrinhDoHocVan = json['idTrinhDoHocVan'].toString();
    idChuyenNganhChinh = json['idChuyenNganhChinh'].toString();
    idSoNamKinhNghiem = json['idSoNamKinhNghiem'].toString();
    idMucLuongDuKien = json['idMucLuongDuKien'].toString();
    noiLamViec = json['noiLamViec'].toString();
    idThoiGianLamViec = json['idThoiGianLamViec'].toString();
    moTaCongViec = json['moTaCongViec'].toString();
    yeuCauCongViec = json['yeuCauCongViec'].toString();
    quyenLoi = json['quyenLoi'].toString();
    uuTien = json['uuTien'].toString();
    hanNopHoSo = json['hanNopHoSo'].toString();
    hoTenLienHe = json['hoTenLienHe'].toString();
    soDienThoaiLienHe = json['soDienThoaiLienHe'].toString();
    diaChiLienHe = json['diaChiLienHe'].toString();
    emailLienHe = json['emailLienHe'].toString();
    idBangGiaDangTin = json['idBangGiaDangTin'].toString();
    idBangGiaLocHoSo = json['idBangGiaLocHoSo'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    data['congTy'] = congTy;
    data['diaChi'] = diaChi;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['gioiTinh'] = gioiTinh;
    data['soLuong'] = soLuong;
    data['idHinhThucLamViec'] = idHinhThucLamViec;
    data['idTrinhDoHocVan'] = idTrinhDoHocVan;
    data['idChuyenNganhChinh'] = idChuyenNganhChinh;
    data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;
    data['idMucLuongDuKien'] = idMucLuongDuKien;
    data['noiLamViec'] = noiLamViec;
    data['idThoiGianLamViec'] = idThoiGianLamViec;
    data['moTaCongViec'] = moTaCongViec;
    data['yeuCauCongViec'] = yeuCauCongViec;
    data['quyenLoi'] = quyenLoi;
    data['uuTien'] = uuTien;
    data['hanNopHoSo'] = hanNopHoSo;
    data['hoTenLienHe'] = hoTenLienHe;
    data['soDienThoaiLienHe'] = soDienThoaiLienHe;
    data['diaChiLienHe'] = diaChiLienHe;
    data['emailLienHe'] = emailLienHe;
    data['idBangGiaDangTin'] = idBangGiaDangTin;
    data['idBangGiaLocHoSo'] = idBangGiaLocHoSo;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['khuyenMai'] = khuyenMai;
    data['soTien'] = soTien;
    data['tongDon'] = tongDon;
    return data;
  }
}
