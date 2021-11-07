class ChiTietCongViecRequest {
    String? idDonDichVu;
    String? tenCongViec;
    String? quyCach;
    String? soLuong;
    String? donVi;
  ChiTietCongViecRequest({
    this.idDonDichVu,
    this.tenCongViec,
    this.quyCach,
    this.soLuong,
    this.donVi,
  });

  ///
  /// From JSON
  ///
  ChiTietCongViecRequest.fromJson(Map<String, dynamic> json) {
    idDonDichVu = (json['idDonDichVu'] == null) ? null : json['idDonDichVu'].toString();
    tenCongViec = json['tenCongViec'].toString();
    quyCach = json['quyCach'].toString();
    soLuong = json['soLuong'].toString();
    donVi = json['donVi'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idDonHang
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec; 

    // check null idSanPham
    if (soLuong != null) data['soLuong'] = soLuong; 

    // check null soLuong
    if (donVi != null) data['donVi'] = donVi; 
    if (quyCach != null) data['quyCach'] = quyCach; 


    return data;
  }
}
