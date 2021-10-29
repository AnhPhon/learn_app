class HonNhanModel {
  String? id;
  String? tieuDe;

  HonNhanModel({
    this.id,
    this.tieuDe,
  });

  ///
  /// From JSON
  ///
  HonNhanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idTaiKhoan
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    return data;
  }

  @override
  String toString() {
    return tieuDe!;
  }
}
