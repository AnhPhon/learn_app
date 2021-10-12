class DieuKhoanChinhSachRequest {
  String? id;
  String? type;
  String? tieuDe;
  String? noiDung;

  DieuKhoanChinhSachRequest({
      this.id,
      this.type,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  DieuKhoanChinhSachRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
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

    // check null type
    if (type != null) data['type'] = type; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
