class BangLuongRequest {
  String? id;
  String? idNhanVien;
  String? file;

  BangLuongRequest({
      this.id,
      this.idNhanVien,
      this.file});
  
  ///
  /// From JSON
  ///
  BangLuongRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    file = json['file'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null file
    if (file != null) data['file'] = file; 


    return data;
  }
}
