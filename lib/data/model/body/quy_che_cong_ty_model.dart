class QuyCheCongTyModel {
  String? tieuDe;
  String? tomTat;
  String? noiDung;

  QuyCheCongTyModel({
      this.tieuDe,
      this.tomTat,
      this.noiDung
      });

  QuyCheCongTyModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    data['tomTat'] = tomTat;
    data['noiDung'] = noiDung;
    return data;
  }
}