class ChiTietVatTuModel {
  String? idDonDichVu;
  String? idVatTu;
  String? soLuong;

  ChiTietVatTuModel({
      this.idDonDichVu,
      this.idVatTu,
      this.soLuong
      });

  ChiTietVatTuModel.fromJson(Map<String, dynamic> json) {
    idDonDichVu = json['idDonDichVu'].toString();
    idVatTu = json['idVatTu'].toString();
    soLuong = json['soLuong'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonDichVu'] = idDonDichVu;
    data['idVatTu'] = idVatTu;
    data['soLuong'] = soLuong;
    return data;
  }
}
