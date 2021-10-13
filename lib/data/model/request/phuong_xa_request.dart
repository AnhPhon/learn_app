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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }
}
