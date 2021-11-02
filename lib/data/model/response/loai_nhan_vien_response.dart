
class LoaiNhanVienResponse {
  String? id;
  String? tieuDe;

  String? createdAt;
  String? updatedAt;

  LoaiNhanVienResponse({
      this.id,
      this.tieuDe,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  LoaiNhanVienResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tieuDe = json['tieuDe'].toString();

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

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 


    return data;
  }
}
