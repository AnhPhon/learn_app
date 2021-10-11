
class HinhThucThanhToanModel {
  String? tieuDe;
  String? noiDung;

  HinhThucThanhToanModel({
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  HinhThucThanhToanModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
