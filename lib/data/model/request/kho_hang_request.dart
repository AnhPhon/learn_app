class KhoHangRequest {
  String? id;
  String? idDuAnNhanVien;
  String? tenKho;
  KhoHangRequest({
      this.id,
      this.idDuAnNhanVien,
      this.tenKho});
  
  ///
  /// From JSON
  ///
  KhoHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    tenKho = json['tenKho'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['tenKho'] = tenKho;
    return data;
  }
}
