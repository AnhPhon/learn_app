class QuanHuyenRequest {
  String? id;
  String? idTinhTp;
  String? ten;

  QuanHuyenRequest({
      this.id,
      this.idTinhTp,
      this.ten});
  
  ///
  /// From JSON
  ///
  QuanHuyenRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    ten = json['ten'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }
}
