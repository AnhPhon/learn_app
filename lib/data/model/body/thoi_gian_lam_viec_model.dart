
class ThoiGianLamViecModel {
  String? tieuDe;

  ThoiGianLamViecModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  ThoiGianLamViecModel.fromJson(Map<String, dynamic> json) {
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
