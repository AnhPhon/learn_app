class DanhSachUngTuyenRequest {
  String? id;
  String? idTuyenDung;
  String? taiKhoanUngTuyen;
  String? daXem;

  DanhSachUngTuyenRequest({
      this.id,
      this.idTuyenDung,
      this.taiKhoanUngTuyen,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachUngTuyenRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    taiKhoanUngTuyen = json['taiKhoanUngTuyen'].toString();
    daXem = json['daXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null taiKhoanUngTuyen
    if (taiKhoanUngTuyen != null) data['taiKhoanUngTuyen'] = taiKhoanUngTuyen; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
