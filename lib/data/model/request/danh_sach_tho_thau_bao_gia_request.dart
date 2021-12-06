class DanhSachThoThauBaoGiaRequest {
  String? id;
  String? idDuAnKhachHang;
  String? idTaiKhoanBaoGia;
  String? idTrangThaiBaoGia;
  String? thoiGianHoanThanh;
  String? giaBao;
  String? ghiChu;
  String? tienCoc;
  String? daXem;

  String? loaiBaoGia;

  // For thothau
  String? idNhomDichVu;
  List<String>? idLoaiCongViecs;
  String? thoiGianBatDauLam;
  int? soLuongNguoi;

  // For daily
  String? idNhomCuaHang;
  List<String>? idMatHangDacTrungs;
  String? noiDungMoTa;

  DanhSachThoThauBaoGiaRequest({
    this.id,
    this.idDuAnKhachHang,
    this.idTaiKhoanBaoGia,
    this.idTrangThaiBaoGia,
    this.thoiGianHoanThanh,
    this.giaBao,
    this.ghiChu,
    this.tienCoc,
    this.daXem,
    this.loaiBaoGia,
    this.idNhomDichVu,
    this.idLoaiCongViecs,
    this.thoiGianBatDauLam,
    this.soLuongNguoi,
    this.idNhomCuaHang,
    this.idMatHangDacTrungs,
    this.noiDungMoTa,
  });

  ///
  /// From JSON
  ///
  DanhSachThoThauBaoGiaRequest.fromJson(Map<String, dynamic> json) {
    if(json['id'] != null) id = (json['id'] == null) ? null : json['id'].toString();
    if(json['idDuAnKhachHang'] != null) idDuAnKhachHang = json['idDuAnKhachHang'].toString();
    if(json['idTaiKhoanBaoGia'] != null) idTaiKhoanBaoGia = json['idTaiKhoanBaoGia'].toString();
    if(json['idTrangThaiBaoGia'] != null) idTrangThaiBaoGia = json['idTrangThaiBaoGia'].toString();
    if(json['thoiGianHoanThanh'] != null) thoiGianHoanThanh = json['thoiGianHoanThanh'].toString();
    if(json['giaBao'] != null) giaBao = json['giaBao'].toString();
    if(json['ghiChu'] != null) ghiChu = json['ghiChu'].toString();
    if(json['tienCoc'] != null) tienCoc = json['tienCoc'].toString();
    if(json['daXem'] != null) daXem = json['daXem'].toString();

    if(json['idNhomDichVu'] != null)  idNhomDichVu = json['idNhomDichVu'].toString();
    if(json['loaiBaoGia'] != null) loaiBaoGia = json['loaiBaoGia'].toString();

    if(json['idLoaiCongViecs'] != null){
      idLoaiCongViecs = [];
      json['idLoaiCongViecs'].map((e) => idLoaiCongViecs!.add(e.toString()));
    }
    if(json['thoiGianBatDauLam'] != null) thoiGianBatDauLam = json['thoiGianBatDauLam'].toString();
    if(json['soLuongNguoi'] != null) soLuongNguoi = int.parse(json['soLuongNguoi'].toString());

    if(json['idNhomCuaHang'] != null) idNhomCuaHang = json['idNhomCuaHang'].toString();
    if(json['idMatHangDacTrungs'] != null){
      idMatHangDacTrungs = [];
      json['idMatHangDacTrungs'].map((e) => idMatHangDacTrungs!.add(e.toString()));
    }
    if(json['noiDungMoTa'] != null) noiDungMoTa = json['noiDungMoTa'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    print('Model print to json idNhomCuaHang $idNhomCuaHang');
    print('Model print to json idNhomCuaHang ${idNhomCuaHang == null}');
    print('Model print to json idNhomCuaHang ${idNhomCuaHang != null}');
    // check null id
    if (id != null) data['id'] = id;

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang;

    // check null taiKhoanBaoGia
    if (idTaiKhoanBaoGia != null) data['idTaiKhoanBaoGia'] = idTaiKhoanBaoGia;

    // check null idTrangThaiBaoGia
    // if (idTrangThaiBaoGia != null) data['idTrangThaiBaoGia'] = idTrangThaiBaoGia;

    // check null thoiGianHoanThanh
    if (thoiGianHoanThanh != null) data['thoiGianHoanThanh'] = thoiGianHoanThanh;

    // check null loaiBaoGia
    if (loaiBaoGia != null) data['loaiBaoGia'] = loaiBaoGia;

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null tienCoc
    if (tienCoc != null) data['tienCoc'] = tienCoc;

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    // check null idLoaiCongViecs
    if (idLoaiCongViecs != null) data['idLoaiCongViecs'] = idLoaiCongViecs;

    // check null thoiGianBatDauLam
    if (thoiGianBatDauLam != null) data['thoiGianBatDauLam'] = thoiGianBatDauLam.toString();

    // check null soLuongNguoi
    if (soLuongNguoi != null) data['soLuongNguoi'] = soLuongNguoi;

    // check null idNhomCuaHang
    if (idNhomCuaHang != null) data['idNhomCuaHang'] = idNhomCuaHang;

    // check null idMatHangDacTrungs
    if (idMatHangDacTrungs != null) data['idMatHangDacTrungs'] = idMatHangDacTrungs;

    // check null noiDungMoTa
    if (noiDungMoTa != null) data['noiDungMoTa'] = noiDungMoTa;

    return data;
  }
}
