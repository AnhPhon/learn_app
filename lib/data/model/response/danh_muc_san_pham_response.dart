class DanhMucSanPhamResponse {
  String? id;
  String? ten;
  String? hinhAnh;

  String? createdAt;
  String? updatedAt;

  DanhMucSanPhamResponse({this.id, this.ten, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  DanhMucSanPhamResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ten = json['ten'].toString();
    hinhAnh = json['hinhAnh'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null ten
    if (ten != null) data['ten'] = ten;

    // check null ten
    if (hinhAnh != null) data['hinhAnh'] = ten;

    return data;
  }
}
