class PhiAppResponse {
  String? id;
  double? donGiaBatDau;
  double? donGiaKetThuc;
  double? phi;

  String? createdAt;
  String? updatedAt;

  PhiAppResponse(
      {this.id,
      this.donGiaBatDau,
      this.donGiaKetThuc,
      this.phi,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  PhiAppResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    if (json['donGiaBatDau'] != null) {
      donGiaBatDau = double.parse(json['donGiaBatDau'].toString());
    } else {
      donGiaBatDau = 0;
    }
    if (json['donGiaKetThuc'] != null) {
      donGiaKetThuc = double.parse(json['donGiaKetThuc'].toString());
    } else {
      donGiaKetThuc = 0;
    }
    if (json['phi'] != null) {
      phi = double.parse(json['phi'].toString());
    } else {
      phi = 0;
    }

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null donGiaBatDau
    if (donGiaBatDau != null) data['donGiaBatDau'] = donGiaBatDau;

    // check null donGiaKetThuc
    if (donGiaKetThuc != null) data['donGiaKetThuc'] = donGiaKetThuc;

    // check null phi
    if (phi != null) data['phi'] = phi;

    return data;
  }
}
