
class NhomDichVuResponse {
  String? id;
  String? tenDichVu;

  String? createdAt;
  String? updatedAt;

  NhomDichVuResponse({
      this.id,
      this.tenDichVu,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  NhomDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenDichVu = json['tenDichVu'].toString();

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

    // check null tenDichVu
    if (tenDichVu != null) data['tenDichVu'] = tenDichVu; 


    return data;
  }
}