class NhanVienRequest {
  String? id;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? hoTen;
  String? soDienThoai;
  String? gioiTinh;
  String? cMND;
  String? ngayCap;
  String? noiCap;
  String? diaChi;
  String? hinhDaiDien;
  String? anhMTCMND;
  String? anhMSCMND;
  String? matKhau;
  String? tokenDevice;
  String? ngaySinh;
  String? email;

  NhanVienRequest({
    this.id,
    this.idTinhTp,
    this.idQuanHuyen,
    this.idPhuongXa,
    this.hoTen,
    this.soDienThoai,
    this.gioiTinh,
    this.cMND,
    this.ngayCap,
    this.noiCap,
    this.diaChi,
    this.hinhDaiDien,
    this.anhMTCMND,
    this.anhMSCMND,
    this.matKhau,
    this.tokenDevice,
    this.ngaySinh,
    this.email,
  });

  ///
  /// From JSON
  ///
  NhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    hoTen = json['hoTen'].toString();
    soDienThoai = json['soDienThoai'].toString();
    gioiTinh = json['gioiTinh'].toString();
    cMND = json['cMND'].toString();
    ngayCap = json['ngayCap'].toString();
    noiCap = json['noiCap'].toString();
    diaChi = json['diaChi'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    anhMTCMND = json['anhMTCMND'].toString();
    anhMSCMND = json['anhMSCMND'].toString();
    matKhau = json['matKhau'].toString();
    tokenDevice = json['tokenDevice'].toString();
    ngaySinh = json['ngaySinh'].toString();
    email = json['email'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null hoTen
    if (hoTen != null) data['hoTen'] = hoTen;

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null cMND
    if (cMND != null) data['cMND'] = cMND;

    // check null ngayCap
    if (ngayCap != null) data['ngayCap'] = ngayCap;

    // check null noiCap
    if (noiCap != null) data['noiCap'] = noiCap;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien;

    // check null anhMTCMND
    if (anhMTCMND != null) data['anhMTCMND'] = anhMTCMND;

    // check null anhMSCMND
    if (anhMSCMND != null) data['anhMSCMND'] = anhMSCMND;

    // check null matKhau
    if (matKhau != null) data['matKhau'] = matKhau;

    // check null tokenDevice
    if (tokenDevice != null) data['tokenDevice'] = tokenDevice;

    // check null Ngay sinh
    if (ngaySinh != null) data['ngaySinh'] = ngaySinh;

    // check null email
    if (email != null) data['email'] = email;

    return data;
  }
}
