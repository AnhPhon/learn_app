class TinTucRequest {
  String? id;
  String? loai;
  String? idDanhMucTinTuc;
  String? tacGia;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? hinhAnh;
  String? luotXem;
  TinTucRequest({
      this.id,
      this.loai,
      this.idDanhMucTinTuc,
      this.tacGia,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.hinhAnh,
      this.luotXem});
  
  ///
  /// From JSON
  ///
  TinTucRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    loai = json['loai'].toString();
    idDanhMucTinTuc = json['idDanhMucTinTuc'].toString();
    tacGia = json['tacGia'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
    hinhAnh = json['hinhAnh'].toString();
    luotXem = json['luotXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
