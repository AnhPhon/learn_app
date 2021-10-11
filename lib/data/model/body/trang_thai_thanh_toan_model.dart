
class TrangThaiThanhToanModel {
  String? tieuDe;

  TrangThaiThanhToanModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  TrangThaiThanhToanModel.fromJson(Map<String, dynamic> json) {
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
