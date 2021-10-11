
class ThongSoKyThuatModel {
  String? tieuDe;

  ThongSoKyThuatModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  ThongSoKyThuatModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 


    return data;
  }
}
