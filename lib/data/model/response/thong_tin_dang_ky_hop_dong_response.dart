
class ThongTinDangKyHopDongResponse {
  String? id;
  String? loai;
  String? tieuDe;
  String? noiDung;
  String? hinhAnh;

  String? createdAt;
  String? updatedAt;

  ThongTinDangKyHopDongResponse({
      this.id,
      this.loai,
      this.tieuDe,
      this.noiDung,
      this.hinhAnh,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongTinDangKyHopDongResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
    hinhAnh = json['hinhAnh'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null loai
    if (loai != null) data['loai'] = loai; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null hinhAnh
    if (hinhAnh != null) data['hinhAnh'] = hinhAnh; 


    return data;
  }
}
