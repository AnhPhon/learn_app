
class BaoHiemResponse {
  String? id;
  String? ten;
  String? hinhAnh;
  String? phi;
  String? loai;
  String? quyenLoi;
  String? boiThuong;
  String? gioiThieu;
  String? chiTiet;

  String? createdAt;
  String? updatedAt;

  BaoHiemResponse({
      this.id,
      this.ten,
      this.hinhAnh,
      this.phi,
      this.loai,
      this.quyenLoi,
      this.boiThuong,
      this.gioiThieu,
      this.chiTiet,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  BaoHiemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ten = json['ten'].toString();
    hinhAnh = json['hinhAnh'].toString();
    phi = json['phi'].toString();
    loai = json['loai'].toString();
    quyenLoi = json['quyenLoi'].toString();
    boiThuong = json['boiThuong'].toString();
    gioiThieu = json['gioiThieu'].toString();
    chiTiet = json['chiTiet'].toString();

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

    // check null ten
    if (ten != null) data['ten'] = ten; 

    // check null hinhAnh
    if (hinhAnh != null) data['hinhAnh'] = hinhAnh; 

    // check null phi
    if (phi != null) data['phi'] = phi; 

    // check null loai
    if (loai != null) data['loai'] = loai; 

    // check null quyenLoi
    if (quyenLoi != null) data['quyenLoi'] = quyenLoi; 

    // check null boiThuong
    if (boiThuong != null) data['boiThuong'] = boiThuong; 

    // check null gioiThieu
    if (gioiThieu != null) data['gioiThieu'] = gioiThieu; 

    // check null chiTiet
    if (chiTiet != null) data['chiTiet'] = chiTiet; 


    return data;
  }
}
