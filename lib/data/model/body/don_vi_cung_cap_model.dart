
class DonViCungCapModel {
  String? tenDonVi;

  DonViCungCapModel({
      this.tenDonVi});
  
  ///
  /// From JSON
  ///
  DonViCungCapModel.fromJson(Map<String, dynamic> json) {
    tenDonVi = json['tenDonVi'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tenDonVi
    if (tenDonVi != null) data['tenDonVi'] = tenDonVi; 


    return data;
  }
}
