class NhomDichVuResponse {
  String? id;
  String? tenDichVu;
  String? nhomDichVu;
  String? hinhAnhDaiDien;
  String? createdAt;
  String? updatedAt;

  NhomDichVuResponse({
    this.id,
    this.tenDichVu,
    this.hinhAnhDaiDien,
    this.createdAt,
    this.updatedAt,
    this.nhomDichVu,
  });

  ///
  /// From JSON
  ///
  NhomDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    if (json['_id'] != null && json['_id'] != 'null') id = json['_id'].toString();
      

    tenDichVu = json['tenDichVu'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    nhomDichVu = json['nhomDichVu'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();

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

    // check null tenDichVu
    if (tenDichVu != null) data['tenDichVu'] = tenDichVu;
    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien;

    // check null nhomDichVu
    if (nhomDichVu != null) data['nhomDichVu'] = nhomDichVu;

    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien;

    return data;
  }

  @override
  String toString() {
    return tenDichVu!;
  }
}
