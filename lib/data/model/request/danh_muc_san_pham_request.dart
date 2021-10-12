class DanhMucSanPhamRequest {
  String? id;
  String? ten;
  DanhMucSanPhamRequest({
      this.id,
      this.ten});
  
  ///
  /// From JSON
  ///
  DanhMucSanPhamRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ten = json['ten'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ten'] = ten;
    return data;
  }
}
