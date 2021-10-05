class DanhMucSanPhamModel {
  String? ten;

  DanhMucSanPhamModel({
      this.ten
      });

  DanhMucSanPhamModel.fromJson(Map<String, dynamic> json) {
    ten = json['ten'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ten'] = ten;
    return data;
  }
}
