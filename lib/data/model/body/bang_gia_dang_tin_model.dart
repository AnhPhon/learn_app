
class BangGiaDangTinModel {
  String? tieuDe;
  String? donGia;

  BangGiaDangTinModel({
      this.tieuDe,
      this.donGia});
  
  ///
  /// From JSON
  ///
  BangGiaDangTinModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    donGia = json['donGia'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    data['donGia'] = donGia;
    return data;
  }
}
