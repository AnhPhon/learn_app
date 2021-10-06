class TinTucModel {
  String? loai;
  String? idDanhMucTinTuc;
  String? tacGia;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? hinhAnh;
  String? luotXem;

  TinTucModel({
      this.loai,
      this.idDanhMucTinTuc,
      this.tacGia,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.hinhAnh,
      this.luotXem
      });

  TinTucModel.fromJson(Map<String, dynamic> json) {
    loai = json['loai'].toString();
    idDanhMucTinTuc = json['idDanhMucTinTuc'].toString();
    tacGia = json['tacGia'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
    hinhAnh = json['hinhAnh'].toString();
    luotXem = json['luotXem'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loai'] = loai;
    data['idDanhMucTinTuc'] = idDanhMucTinTuc;
    data['tacGia'] = tacGia;
    data['tieuDe'] = tieuDe;
    data['tomTat'] = tomTat;
    data['noiDung'] = noiDung;
    data['hinhAnh'] = hinhAnh;
    data['luotXem'] = luotXem;
    return data;
  }
}
