class BangGiaDangTinResponse {
  String? id;
  String? tieuDe;
  String? donGia;

  String? createdAt;
  String? updatedAt;

  BangGiaDangTinResponse(
      {this.id, this.tieuDe, this.donGia, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  BangGiaDangTinResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    donGia = json['donGia'].toString();

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

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null donGia
    if (donGia != null) data['donGia'] = donGia;

    return data;
  }

  @override
  String toString() {
    return tieuDe!;
  }
}
