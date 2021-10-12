class TaiKhoanRequest {
  String? id;
  String? idLoaiTaiKhoan;
  String? tinhTpHoatDong;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? loaiPhapLy;
  String? tenPhapLy;
  String? mST;
  String? hoTen;
  String? ngaySinh;
  String? gioiTinh;
  String? cMND;
  String? ngayCap;
  String? noiCap;
  String? soDienThoai;
  String? email;
  String? diaChi;
  String? viTien;
  String? hinhDaiDien;
  String? matKhau;
  String? tokenDevice;
  String? soLuongNguoi;
  String? chuyenMon;
  String? gioiThieu;
  String? noiLamViec;
  String? hinhCMNDTruoc;
  String? hinhCMNDSau;
  String? idNhomCuaHang;
  String? idMatHangDacTrung;
  String? diaChiKhoHang;
  String? thoiGianLamViec;
  String? lamChieuThuBay;
  String? lamNgayChuNhat;
  TaiKhoanRequest({
      this.id,
      this.idLoaiTaiKhoan,
      this.tinhTpHoatDong,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.loaiPhapLy,
      this.tenPhapLy,
      this.mST,
      this.hoTen,
      this.ngaySinh,
      this.gioiTinh,
      this.cMND,
      this.ngayCap,
      this.noiCap,
      this.soDienThoai,
      this.email,
      this.diaChi,
      this.viTien,
      this.hinhDaiDien,
      this.matKhau,
      this.tokenDevice,
      this.soLuongNguoi,
      this.chuyenMon,
      this.gioiThieu,
      this.noiLamViec,
      this.hinhCMNDTruoc,
      this.hinhCMNDSau,
      this.idNhomCuaHang,
      this.idMatHangDacTrung,
      this.diaChiKhoHang,
      this.thoiGianLamViec,
      this.lamChieuThuBay,
      this.lamNgayChuNhat});
  
  ///
  /// From JSON
  ///
  TaiKhoanRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idLoaiTaiKhoan = json['idLoaiTaiKhoan'].toString();
    tinhTpHoatDong = json['tinhTpHoatDong'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    loaiPhapLy = json['loaiPhapLy'].toString();
    tenPhapLy = json['tenPhapLy'].toString();
    mST = json['mST'].toString();
    hoTen = json['hoTen'].toString();
    ngaySinh = json['ngaySinh'].toString();
    gioiTinh = json['gioiTinh'].toString();
    cMND = json['cMND'].toString();
    ngayCap = json['ngayCap'].toString();
    noiCap = json['noiCap'].toString();
    soDienThoai = json['soDienThoai'].toString();
    email = json['email'].toString();
    diaChi = json['diaChi'].toString();
    viTien = json['viTien'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    matKhau = json['matKhau'].toString();
    tokenDevice = json['tokenDevice'].toString();
    soLuongNguoi = json['soLuongNguoi'].toString();
    chuyenMon = json['chuyenMon'].toString();
    gioiThieu = json['gioiThieu'].toString();
    noiLamViec = json['noiLamViec'].toString();
    hinhCMNDTruoc = json['hinhCMNDTruoc'].toString();
    hinhCMNDSau = json['hinhCMNDSau'].toString();
    idNhomCuaHang = json['idNhomCuaHang'].toString();
    idMatHangDacTrung = json['idMatHangDacTrung'].toString();
    diaChiKhoHang = json['diaChiKhoHang'].toString();
    thoiGianLamViec = json['thoiGianLamViec'].toString();
    lamChieuThuBay = json['lamChieuThuBay'].toString();
    lamNgayChuNhat = json['lamNgayChuNhat'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idLoaiTaiKhoan'] = idLoaiTaiKhoan;
    data['tinhTpHoatDong'] = tinhTpHoatDong;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['loaiPhapLy'] = loaiPhapLy;
    data['tenPhapLy'] = tenPhapLy;
    data['mST'] = mST;
    data['hoTen'] = hoTen;
    data['ngaySinh'] = ngaySinh;
    data['gioiTinh'] = gioiTinh;
    data['cMND'] = cMND;
    data['ngayCap'] = ngayCap;
    data['noiCap'] = noiCap;
    data['soDienThoai'] = soDienThoai;
    data['email'] = email;
    data['diaChi'] = diaChi;
    data['viTien'] = viTien;
    data['hinhDaiDien'] = hinhDaiDien;
    data['matKhau'] = matKhau;
    data['tokenDevice'] = tokenDevice;
    data['soLuongNguoi'] = soLuongNguoi;
    data['chuyenMon'] = chuyenMon;
    data['gioiThieu'] = gioiThieu;
    data['noiLamViec'] = noiLamViec;
    data['hinhCMNDTruoc'] = hinhCMNDTruoc;
    data['hinhCMNDSau'] = hinhCMNDSau;
    data['idNhomCuaHang'] = idNhomCuaHang;
    data['idMatHangDacTrung'] = idMatHangDacTrung;
    data['diaChiKhoHang'] = diaChiKhoHang;
    data['thoiGianLamViec'] = thoiGianLamViec;
    data['lamChieuThuBay'] = lamChieuThuBay;
    data['lamNgayChuNhat'] = lamNgayChuNhat;
    return data;
  }
}
