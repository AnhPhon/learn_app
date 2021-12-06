class DanhSachBaoGiaDonDichVuRequest {
  String? id;
  String? idDonDichVu;
  String? idTaiKhoanBaoGia;
  String? tongTien;
  String? ghiChu;
  String? file;
  String? daXem;
  String? thongTinBaoGia;
  String? phiVanChuyen;
  String? thoiGianVanChuyenBatDau;
  String? thoiGianVanChuyenKetThuc;
  List<String>? hinhAnhBaoGias;
  List<GiaVatTuRequest>? giaVatTus;
  List<GiaCongViecRequest>? giaCongViecs;
  String? baoGiaTheo;

  DanhSachBaoGiaDonDichVuRequest({
    this.id,
    this.idDonDichVu,
    this.idTaiKhoanBaoGia,
    this.tongTien,
    this.ghiChu,
    this.file,
    this.daXem,
    this.thongTinBaoGia,
    this.phiVanChuyen,
    this.thoiGianVanChuyenBatDau,
    this.thoiGianVanChuyenKetThuc,
    this.hinhAnhBaoGias,
    this.baoGiaTheo,
  });

  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idTaiKhoanBaoGia = json['idTaiKhoanBaoGia'].toString();
    if (json['tongTien'] != null && json['tongTien'] != 'null') {
      tongTien = json['tongTien'].toString();
    }
    if (json['ghiChu'] != null && json['ghiChu'] != 'null') {
      ghiChu = json['ghiChu'].toString();
    }
    if (json['file'] != null && json['file'] != 'null') {
      file = json['file'].toString();
    }
    if (json['daXem'] != null && json['daXem'] != 'null') {
      daXem = json['daXem'].toString();
    }
    if (json['thongTinBaoGia'] != null && json['thongTinBaoGia'] != 'null') {
      thongTinBaoGia = json['thongTinBaoGia'].toString();
    }
    if (json['phiVanChuyen'] != null && json['phiVanChuyen'] != 'null') {
      phiVanChuyen = json['phiVanChuyen'].toString();
    }
    if (json['thoiGianVanChuyenBatDau'] != null &&
        json['thoiGianVanChuyenBatDau'] != 'null') {
      thoiGianVanChuyenBatDau = json['thoiGianVanChuyenBatDau'].toString();
    }
    if (json['thoiGianVanChuyenKetThuc'] != null &&
        json['thoiGianVanChuyenKetThuc'] != 'null') {
      thoiGianVanChuyenKetThuc = json['thoiGianVanChuyenKetThuc'].toString();
    }
    // trangThaiBaoGia = json['trangThaiBaoGia'].toString();
    baoGiaTheo = json['baoGiaTheo'].toString();

    if (json['hinhAnhBaoGias'] != null) {
      hinhAnhBaoGias =
          (json['hinhAnhBaoGias'] as List<dynamic>).cast<String>().toList();
    }
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu;

    // check null idTaiKhoanBaoGia
    if (idTaiKhoanBaoGia != null) data['idTaiKhoanBaoGia'] = idTaiKhoanBaoGia;

    // check null giaBao
    if (tongTien != null) data['tongTien'] = tongTien;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null file
    if (file != null) data['file'] = file;

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null trangThaiBaoGia
    if (thongTinBaoGia != null) data['thongTinBaoGia'] = thongTinBaoGia;

    // check null daXem
    if (hinhAnhBaoGias != null) data['hinhAnhBaoGias'] = hinhAnhBaoGias;

    // check null daXem
    if (giaVatTus != null) data['giaVatTus'] = giaVatTus;

    // check null daXem
    if (giaCongViecs != null) data['giaCongViecs'] = giaCongViecs;

    // check null baoGiaTheo
    if (baoGiaTheo != null) data['baoGiaTheo'] = baoGiaTheo;

    // check null thoiGianVanChuyenBatDau
    if (thoiGianVanChuyenBatDau != null) {
      data['thoiGianVanChuyenBatDau'] = thoiGianVanChuyenBatDau;
    }

    // check null thoiGianVanChuyenKetThuc
    if (thoiGianVanChuyenKetThuc != null) {
      data['thoiGianVanChuyenKetThuc'] = thoiGianVanChuyenKetThuc;
    }

    // check null phiVanChuyen
    if (phiVanChuyen != null) {
      data['phiVanChuyen'] = phiVanChuyen;
    }

    return data;
  }
}

class GiaVatTuRequest {
  String? id;
  String? idChiTietVatTu;
  String? donGia;

  GiaVatTuRequest({
    this.id,
    this.idChiTietVatTu,
    this.donGia,
  });

  ///
  /// From JSON
  ///
  GiaVatTuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idChiTietVatTu = json['idChiTietVatTu'].toString();
    donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idDonDichVu
    if (idChiTietVatTu != null) data['idChiTietVatTu'] = idChiTietVatTu;

    // check null idTaiKhoanBaoGia
    if (donGia != null) data['donGia'] = donGia;

    return data;
  }
}

class GiaCongViecRequest {
  String? id;
  String? idChiTietCongViec;
  String? donGia;

  GiaCongViecRequest({
    this.id,
    this.idChiTietCongViec,
    this.donGia,
  });

  ///
  /// From JSON
  ///
  GiaCongViecRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idChiTietCongViec = json['idChiTietCongViec'].toString();
    donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idDonDichVu
    if (idChiTietCongViec != null) {
      data['idChiTietCongViec'] = idChiTietCongViec;
    }

    // check null idTaiKhoanBaoGia
    if (donGia != null) data['donGia'] = donGia;

    return data;
  }
}
