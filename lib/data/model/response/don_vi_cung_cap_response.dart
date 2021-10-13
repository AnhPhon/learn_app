
class DonViCungCapResponse {
  String? id;
  String? tenDonVi;

  String? createdAt;
  String? updatedAt;

  DonViCungCapResponse({
      this.id,
      this.tenDonVi,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DonViCungCapResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenDonVi = json['tenDonVi'].toString();

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

    // check null tenDonVi
    if (tenDonVi != null) data['tenDonVi'] = tenDonVi; 


    return data;
  }
}
