
class BangGiaLocHoSoModel {
  String? tieuDe;
  String? donGia;

  BangGiaLocHoSoModel({
      this.tieuDe,
      this.donGia});
  
  ///
  /// From JSON
  ///
  BangGiaLocHoSoModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    donGia = json['donGia'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null donGia
    if (donGia != null) data['donGia'] = donGia; 


    return data;
  }
}
