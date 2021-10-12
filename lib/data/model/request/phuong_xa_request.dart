class PhuongXaRequest {
  String? id;
  String? idQuanHuyen;
  String? ten;
  PhuongXaRequest({
      this.id,
      this.idQuanHuyen,
      this.ten});
  
  ///
  /// From JSON
  ///
  PhuongXaRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    ten = json['ten'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idQuanHuyen'] = idQuanHuyen;
    data['ten'] = ten;
    return data;
  }
}
