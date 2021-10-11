import 'danh_muc_tin_tuc_model.dart';

class TinTucModel {
  String? loai;
  DanhMucTinTucModel? idDanhMucTinTuc;
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
      this.luotXem});
  
  ///
  /// From JSON
  ///
  TinTucModel.fromJson(Map<String, dynamic> json) {
    loai = json['loai'].toString();

    // mapping idDanhMucTinTuc                                                              
    if (json['idDanhMucTinTuc'] != null) {                                                  
      idDanhMucTinTuc = DanhMucTinTucModel.fromJson(json['idDanhMucTinTuc'] as Map<String, dynamic>); 
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
