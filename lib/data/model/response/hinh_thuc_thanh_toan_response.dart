
class HinhThucThanhToanResponse {
  String? id;
  String? tieuDe;
  String? noiDung;

  String? createdAt;
  String? updatedAt;

  HinhThucThanhToanResponse({
      this.id,
      this.tieuDe,
      this.noiDung,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  HinhThucThanhToanResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

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

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
