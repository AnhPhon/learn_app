class CaiDatChungResponse {
  String? id;
  double? khuyenMai;

  String? createdAt;
  String? updatedAt;

  CaiDatChungResponse(
      {this.id, this.khuyenMai, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  CaiDatChungResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    if (json['khuyenMai'] != null) {
      khuyenMai = double.parse(json['khuyenMai'].toString());
    } else {
      khuyenMai = 0;
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

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai;

    return data;
  }
}
