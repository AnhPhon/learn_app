
class BangGiaChiTietThamKhaoRequest {
  String? id;
  List<String>? hinhAnhs;
  List<String>? files;
  String? idNhomDichVu;
  BangGiaChiTietThamKhaoRequest({
    this.id,
    this.hinhAnhs,
    this.files,
    this.idNhomDichVu,
  });
  

  ///
  /// From JSON
  ///
  BangGiaChiTietThamKhaoRequest.fromJson(Map<String, dynamic> json) {
    hinhAnhs = json['hinhAnhs'] as List<String>;

    files = json['files'] as List<String>;
    idNhomDichVu = json['idNhomDichVu'].toString();
    id = json['id'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 
    if (hinhAnhs != null) data['hinhAnhs'] = hinhAnhs; 

    // check null idDonDichVu
    if (files != null) data['files'] = files; 

    // check null idVatTu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu; 

    return data;
  }
}
