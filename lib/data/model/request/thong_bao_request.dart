class ThongBaoRequest {
  String? id;
  String? status;
  String? doiTuong;
  String? idDonDichVu;
  String? idDuAnKhachHang;
  String? idTinTuc;
  String? idTuyenDung;
  String? tieuDe;
  String? noiDung;
  String? hinhDaiDien;
  String? idDuAnNhanVien;

  ThongBaoRequest({
      this.id,
      this.doiTuong,
      this.idDonDichVu,
      this.idDuAnKhachHang,
      this.idTinTuc,
      this.idTuyenDung,
      this.tieuDe,
      this.noiDung,
      this.hinhDaiDien,
      this.idDuAnNhanVien});
  
  ///
  /// From JSON
  ///
  ThongBaoRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    status = (json['status'] == null) ? null : json['status'].toString();
    doiTuong = json['doiTuong'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idDuAnKhachHang = json['idDuAnKhachHang'].toString();
    idTinTuc = json['idTinTuc'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null doiTuong
    if (doiTuong != null) data['doiTuong'] = doiTuong; 
    
    // Check status
    if (status != null) data['status'] = status; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang; 

    // check null idTinTuc
    if (idTinTuc != null) data['idTinTuc'] = idTinTuc; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 


    return data;
  }
}
