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
    id = json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    ten = json['ten'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTinhTp'] = idTinhTp;
    data['ten'] = ten;
    return data;
  }
}
