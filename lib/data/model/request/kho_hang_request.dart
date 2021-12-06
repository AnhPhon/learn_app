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
    id = (json['id'] == null) ? null : json['id'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    tenKho = json['tenKho'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null tenKho
    if (tenKho != null) data['tenKho'] = tenKho; 


    return data;
  }
}
