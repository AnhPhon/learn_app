
class TrangThaiThanhToanResponse {
  String? id;
  String? tieuDe;

  TrangThaiThanhToanResponse({
      this.id,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  TrangThaiThanhToanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();

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
