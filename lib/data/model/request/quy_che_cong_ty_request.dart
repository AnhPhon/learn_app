class QuyCheCongTyRequest {
  String? id;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  QuyCheCongTyRequest({
      this.id,
      this.tieuDe,
      this.tomTat,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  QuyCheCongTyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    data['tomTat'] = tomTat;
    data['noiDung'] = noiDung;
    return data;
  }
}
