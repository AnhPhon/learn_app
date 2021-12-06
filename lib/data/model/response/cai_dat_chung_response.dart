class CaiDatChungResponse {
  String? id;
  double? khuyenMai;
  String? linkAndroid;
  String? linkIos;

  String? createdAt;
  String? updatedAt;

  CaiDatChungResponse({
    this.id,
    this.khuyenMai,
    this.linkAndroid,
    this.linkIos,
    this.createdAt,
    this.updatedAt,
  });

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
    if (json['linkAndroid'] != null) {
      linkAndroid = json['linkAndroid'].toString();
    }
    if (json['linkIOS'] != null) {
      linkIos = json['linkIOS'].toString();
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

    // check null linkAndroid
    if (linkAndroid != null) data['linkAndroid'] = linkAndroid;

    // check null linkIos
    if (linkIos != null) data['linkIOS'] = linkIos;

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai;

    return data;
  }
}
