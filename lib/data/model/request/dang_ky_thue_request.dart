class DangKyThueRequest {
  String? id;
  String? idTaiKhoan;
  String? file;
  String? trangThai;
  List<dynamic>? hinhAnhs;
  String? loai;

  DangKyThueRequest({
    this.id,
    this.idTaiKhoan,
    this.file,
    this.trangThai,
    this.hinhAnhs,
    this.loai,
  });

  ///
  /// From JSON
  ///
  DangKyThueRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();

    hinhAnhs = json['hinhAnhs'] as List<dynamic>;

    loai = json['loai'].toString();
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

    // check null file
    if (file != null) data['file'] = file;

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai;

    // check null hinhAnhs
    if (hinhAnhs != null) data['hinhAnhs'] = hinhAnhs;

    // check null loai
    if (loai != null) data['loai'] = loai;

    return data;
  }
}
