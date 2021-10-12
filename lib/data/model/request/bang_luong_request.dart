class BangLuongRequest {
  String? id;
  String? idNhanVien;
  String? file;
  BangLuongRequest({
      this.id,
      this.idNhanVien,
      this.file});
  
  ///
  /// From JSON
  ///
  BangLuongRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    file = json['file'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNhanVien'] = idNhanVien;
    data['file'] = file;
    return data;
  }
}
