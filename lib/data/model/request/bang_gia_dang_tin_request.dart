class BangGiaDangTinRequest {
  String? id;
  String? tieuDe;
  String? donGia;
  BangGiaDangTinRequest({
      this.id,
      this.tieuDe,
      this.donGia});
  
  ///
  /// From JSON
  ///
  BangGiaDangTinRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    data['donGia'] = donGia;
    return data;
  }
}
