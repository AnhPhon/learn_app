class ChuyenNganhChinhRequest {
  String? id;
  String? tieuDe;
  ChuyenNganhChinhRequest({
      this.id,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  ChuyenNganhChinhRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
