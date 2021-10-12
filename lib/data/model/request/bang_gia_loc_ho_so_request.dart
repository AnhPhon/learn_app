class BangGiaLocHoSoRequest {
  String? id;
  String? tieuDe;
  String? donGia;

  BangGiaLocHoSoRequest({
      this.id,
      this.tieuDe,
      this.donGia});
  
  ///
  /// From JSON
  ///
  BangGiaLocHoSoRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null donGia
    if (donGia != null) data['donGia'] = donGia; 


    return data;
  }
}
