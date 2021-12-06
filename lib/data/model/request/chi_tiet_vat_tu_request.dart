class ChiTietVatTuRequest {
  String? id;
  String? idDonDichVu;
  String? idVatTu;
  String? idTaiKhoan;
  String? soLuong;
  String? donGia;

  ChiTietVatTuRequest({
    this.id,
    this.idDonDichVu,
    this.idVatTu,
    this.soLuong,
    this.donGia,
    this.idTaiKhoan,
  });

  ///
  /// From JSON
  ///
  ChiTietVatTuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idVatTu = json['idVatTu'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    soLuong = json['soLuong'].toString();
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
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu;

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null donGia
    if (donGia != null) data['donGia'] = donGia;

    return data;
  }
}
