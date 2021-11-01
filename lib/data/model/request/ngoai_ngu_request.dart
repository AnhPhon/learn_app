class NgoaiNguRequest {
  String? id;
  String? idTaiKhoan;
  String? loaiNgoaiNgu;
  String? trinhDo;
  String? nghe;
  String? noi;
  String? doc;
  String? viet;

  NgoaiNguRequest({
      this.id,
      this.idTaiKhoan,
      this.loaiNgoaiNgu,
      this.trinhDo,
      this.nghe,
      this.noi,
      this.doc,
      this.viet});
  
  ///
  /// From JSON
  ///
  NgoaiNguRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    loaiNgoaiNgu = json['loaiNgoaiNgu'].toString();
    trinhDo = json['trinhDo'].toString();
    nghe = json['nghe'].toString();
    noi = json['noi'].toString();
    doc = json['doc'].toString();
    viet = json['viet'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null loaiNgoaiNgu
    if (loaiNgoaiNgu != null) data['loaiNgoaiNgu'] = loaiNgoaiNgu; 

    // check null trinhDo
    if (trinhDo != null) data['trinhDo'] = trinhDo; 

    // check null nghe
    if (nghe != null) data['nghe'] = nghe; 

    // check null noi
    if (noi != null) data['noi'] = noi; 

    // check null doc
    if (doc != null) data['doc'] = doc; 

    // check null viet
    if (viet != null) data['viet'] = viet; 


    return data;
  }
}
