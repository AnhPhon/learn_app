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
    id = json['id'].toString();
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
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['loaiNgoaiNgu'] = loaiNgoaiNgu;
    data['trinhDo'] = trinhDo;
    data['nghe'] = nghe;
    data['noi'] = noi;
    data['doc'] = doc;
    data['viet'] = viet;
    return data;
  }
}
