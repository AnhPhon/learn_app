class LienHeRiengRequest {
  String? id;
  String? ngayGiaoDich;
  String? giaTriGiaoDich;
  String? noiDung;
  String? idTaiKhoan;

  LienHeRiengRequest({
      this.id,
      this.ngayGiaoDich,
      this.giaTriGiaoDich,
      this.noiDung,
      this.idTaiKhoan});
  
  ///
  /// From JSON
  ///
  LienHeRiengRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ngayGiaoDich = json['ngayGiaoDich'].toString();
    giaTriGiaoDich = json['giaTriGiaoDich'].toString();
    noiDung = json['noiDung'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null ngayGiaoDich
    if (ngayGiaoDich != null) data['ngayGiaoDich'] = ngayGiaoDich; 

    // check null giaTriGiaoDich
    if (giaTriGiaoDich != null) data['giaTriGiaoDich'] = giaTriGiaoDich; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 


    return data;
  }
}
