
class SoNamKinhNghiemModel {
  String? tieuDe;

  SoNamKinhNghiemModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  SoNamKinhNghiemModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    return data;
  }
}
