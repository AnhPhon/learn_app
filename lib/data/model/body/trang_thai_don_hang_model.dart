
class TrangThaiDonHangModel {
  String? tieuDe;

  TrangThaiDonHangModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  TrangThaiDonHangModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 


    return data;
  }
}
