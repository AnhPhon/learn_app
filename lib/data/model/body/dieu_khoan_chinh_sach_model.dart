
class DieuKhoanChinhSachModel {
  String? type;
  String? tieuDe;
  String? noiDung;

  DieuKhoanChinhSachModel({
      this.type,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  DieuKhoanChinhSachModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null type
    if (type != null) data['type'] = type; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
