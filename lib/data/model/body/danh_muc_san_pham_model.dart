
class DanhMucSanPhamModel {
  String? ten;

  DanhMucSanPhamModel({
      this.ten});
  
  ///
  /// From JSON
  ///
  DanhMucSanPhamModel.fromJson(Map<String, dynamic> json) {
    ten = json['ten'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }
}
