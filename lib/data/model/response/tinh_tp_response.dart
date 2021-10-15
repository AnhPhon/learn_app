
class TinhTpResponse {
  String? id;
  String? ten;

  String? createdAt;
  String? updatedAt;

  TinhTpResponse({
      this.id,
      this.ten,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  TinhTpResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ten = json['ten'].toString();

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


    return data;
  }

  @override
  String toString() {
    return ten!;
  }
}
