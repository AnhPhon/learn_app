
class ChuyenNganhChinhModel {
  String? tieuDe;

  ChuyenNganhChinhModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  ChuyenNganhChinhModel.fromJson(Map<String, dynamic> json) {
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
