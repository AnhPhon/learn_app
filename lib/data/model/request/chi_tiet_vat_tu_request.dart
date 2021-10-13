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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu; 

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong; 


    return data;
  }
}
