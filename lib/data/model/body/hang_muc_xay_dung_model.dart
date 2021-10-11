
class HangMucXayDungModel {
  String? tieuDe;
  String? hinhAnh;

  HangMucXayDungModel({
      this.tieuDe,
      this.hinhAnh});
  
  ///
  /// From JSON
  ///
  HangMucXayDungModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    hinhAnh = json['hinhAnh'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    data['hinhAnh'] = hinhAnh;
    return data;
  }
}
