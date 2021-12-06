class ChiTietCongViecRequest {
  String? id;
  String? idDonDichVu;
  String? tenCongViec;
  String? quyCach;
  String? soLuong;
  String? donVi;
  String? donGia;

  ChiTietCongViecRequest({
    this.id,
    this.idDonDichVu,
    this.tenCongViec,
    this.quyCach,
    this.soLuong,
    this.donVi,
    this.donGia,
  });

  ///
  /// From JSON
  ///
  ChiTietCongViecRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idDonDichVu
    if (json != null && json['idDonDichVu'] != null) {
      idDonDichVu = json['idDonDichVu'].toString();
    }
    // mapping tenCongViec
    if (json != null && json['tenCongViec'] != null) {
      tenCongViec = json['tenCongViec'].toString();
    }
    // mapping quyCach
    if (json != null && json['quyCach'] != null) {
      quyCach = json['quyCach'].toString();
    }
    // mapping soLuong
    if (json != null && json['soLuong'] != null) {
      soLuong = json['soLuong'].toString();
    }
    // mapping soLuong
    if (json != null && json['donGia'] != null) {
      donGia = json['donGia'].toString();
    }
    // mapping donVi
    if (json != null && json['donVi'] != null) {
      donVi = json['donVi'].toString();
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

    // check null tenCongViec
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec;

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null donVi
    if (donVi != null) data['donVi'] = donVi;

    // check null donGia
    if (donGia != null) data['donGia'] = donGia;

    return data;
  }
}
