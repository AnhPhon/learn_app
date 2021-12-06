class DiaDiemDangKyLamViecRequest {
  String? id;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;

  DiaDiemDangKyLamViecRequest(
      {this.id, this.idTinhTp, this.idQuanHuyen, this.idPhuongXa});

  ///
  /// From JSON
  ///
  DiaDiemDangKyLamViecRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
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

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    return data;
  }
}
