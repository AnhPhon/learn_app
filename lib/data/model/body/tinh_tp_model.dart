
class TinhTpModel {
  String? ten;

  TinhTpModel({
      this.ten});
  
  ///
  /// From JSON
  ///
  TinhTpModel.fromJson(Map<String, dynamic> json) {
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
