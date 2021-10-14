
class QuyCheCongTyResponse {
  String? id;
  String? tieuDe;
  String? tomTat;
  String? noiDung;

  String? createdAt;
  String? updatedAt;

  QuyCheCongTyResponse({
      this.id,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  QuyCheCongTyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
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

    // check null tomTat
    if (tomTat != null) data['tomTat'] = tomTat; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
