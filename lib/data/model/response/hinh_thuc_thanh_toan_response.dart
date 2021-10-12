
class HinhThucThanhToanResponse {
  String? id;
  String? tieuDe;
  String? noiDung;

  HinhThucThanhToanResponse({
      this.id,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  HinhThucThanhToanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

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
