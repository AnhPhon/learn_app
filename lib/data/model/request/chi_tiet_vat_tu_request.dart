class ChiTietVatTuRequest {
  String? id;
  String? idDonDichVu;
  String? idVatTu;
  String? soLuong;
  ChiTietVatTuRequest({
      this.id,
      this.idDonDichVu,
      this.idVatTu,
      this.soLuong});
  
  ///
  /// From JSON
  ///
  ChiTietVatTuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idVatTu = json['idVatTu'].toString();
    soLuong = json['soLuong'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDonDichVu'] = idDonDichVu;
    data['idVatTu'] = idVatTu;
    data['soLuong'] = soLuong;
    return data;
  }
}
