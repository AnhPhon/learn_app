class LoaiCongTrinhRequest {
  String? id;
  String? tenCongTrinh;
  LoaiCongTrinhRequest({
    this.id,
    this.tenCongTrinh,
  });
  LoaiCongTrinhRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tenCongTrinh = json['tenCongTrinh'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    if (tenCongTrinh != null) data['tenCongTrinh'] = tenCongTrinh; 

    return data;
  }

  @override
  String toString() {
    return tenCongTrinh!;
  }

}