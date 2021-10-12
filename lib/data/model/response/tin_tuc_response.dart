import 'danh_muc_tin_tuc_response.dart';

class TinTucResponse {
  String? id;
  String? loai;
  DanhMucTinTucResponse? idDanhMucTinTuc;
  String? tacGia;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? hinhAnh;
  String? luotXem;

  TinTucResponse({
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
  TinTucResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    loai = json['loai'].toString();

    // mapping idDanhMucTinTuc                                                              
    if (json['idDanhMucTinTuc'] != null && json['idDanhMucTinTuc'].toString().length!=24) {                                                  
      idDanhMucTinTuc = DanhMucTinTucResponse.fromJson(json['idDanhMucTinTuc'] as Map<String, dynamic>); 
    } else {                                                                           
      idDanhMucTinTuc = null;                                                               
    }                                                                                  
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
    // check null id
    if (id != null) data['id'] = id; 

    // check null loai
    if (loai != null) data['loai'] = loai; 

    // check null idDanhMucTinTuc
    if (idDanhMucTinTuc != null) data['idDanhMucTinTuc'] = idDanhMucTinTuc; 

    // check null tacGia
    if (tacGia != null) data['tacGia'] = tacGia; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null tomTat
    if (tomTat != null) data['tomTat'] = tomTat; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null hinhAnh
    if (hinhAnh != null) data['hinhAnh'] = hinhAnh; 

    // check null luotXem
    if (luotXem != null) data['luotXem'] = luotXem; 


    return data;
  }
}
