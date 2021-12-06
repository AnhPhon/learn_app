class YeuCauBaoHanhResponse {
  String? id;
  String? noiDung;
  List<String>? hinhAnhs;
  String? danhGiaBaoHanh;
  String? loai;

  String? createdAt;
  String? updatedAt;

  YeuCauBaoHanhResponse(
      {this.id,
      this.noiDung,
      this.hinhAnhs,
      this.danhGiaBaoHanh,
      this.loai,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  YeuCauBaoHanhResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    noiDung = json['noiDung'].toString();
    if (json['hinhAnhs'] != null) {
      hinhAnhs =
          (json['hinhAnhs'] as List<dynamic>).map((e) => e.toString()).toList();
    }
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    loai = json['loai'].toString();

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

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung;

    // check null hinhAnhs
    if (hinhAnhs != null) {
      data['hinhAnhs'] = hinhAnhs!.map((e) => e.toString()).toList();
    }

    // check null danhGiaBaoHanh
    if (danhGiaBaoHanh != null) data['danhGiaBaoHanh'] = danhGiaBaoHanh;

    // check null loai
    if (loai != null) data['loai'] = loai;

    return data;
  }

  @override
  String toString() {
    return noiDung.toString();
  }
}