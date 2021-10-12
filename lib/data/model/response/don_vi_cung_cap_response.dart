
class DonViCungCapResponse {
  String? id;
  String? tenDonVi;

  DonViCungCapResponse({
      this.id,
      this.tenDonVi});
  
  ///
  /// From JSON
  ///
  DonViCungCapResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenDonVi = json['tenDonVi'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tenDonVi
    if (tenDonVi != null) data['tenDonVi'] = tenDonVi; 


    return data;
  }
}
