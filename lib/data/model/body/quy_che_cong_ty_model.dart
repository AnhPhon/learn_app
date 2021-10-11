
class QuyCheCongTyModel {
  String? tieuDe;
  String? tomTat;
  String? noiDung;

  QuyCheCongTyModel({
      this.tieuDe,
      this.tomTat,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  QuyCheCongTyModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null tomTat
    if (tomTat != null) data['tomTat'] = tomTat; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
