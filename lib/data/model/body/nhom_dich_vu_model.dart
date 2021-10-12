
class NhomDichVuModel {
  String? tenDichVu;

  NhomDichVuModel({
      this.tenDichVu});
  
  ///
  /// From JSON
  ///
  NhomDichVuModel.fromJson(Map<String, dynamic> json) {
    tenDichVu = json['tenDichVu'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tenDichVu
    if (tenDichVu != null) data['tenDichVu'] = tenDichVu; 


    return data;
  }

  @override
  String toString() {
      return tenDichVu!;
  }
}
