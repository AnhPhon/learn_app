class PhiAppRequest {
  String? id;
  String? donGiaBatDau;
  String? donGiaKetThuc;
  String? phi;

  PhiAppRequest({
      this.id,
      this.donGiaBatDau,
      this.donGiaKetThuc,
      this.phi});
  
  ///
  /// From JSON
  ///
  PhiAppRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    donGiaBatDau = json['donGiaBatDau'].toString();
    donGiaKetThuc = json['donGiaKetThuc'].toString();
    phi = json['phi'].toString();
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
