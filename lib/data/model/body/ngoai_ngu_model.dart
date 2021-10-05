class NgoaiNguModel {
  String? idTaiKhoan;
  String? loaiNgoaiNgu;
  String? trinhDo;
  String? nghe;
  String? noi;
  String? doc;
  String? viet;

  NgoaiNguModel({
      this.idTaiKhoan,
      this.loaiNgoaiNgu,
      this.trinhDo,
      this.nghe,
      this.noi,
      this.doc,
      this.viet
      });

  NgoaiNguModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    loaiNgoaiNgu = json['loaiNgoaiNgu'].toString();
    trinhDo = json['trinhDo'].toString();
    nghe = json['nghe'].toString();
    noi = json['noi'].toString();
    doc = json['doc'].toString();
    viet = json['viet'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
