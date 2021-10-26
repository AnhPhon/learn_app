class GioiTinhModel {
  String? key;
  String? value;

  GioiTinhModel({
    this.key,
    this.value,
  });

  ///
  /// From JSON
  ///
  GioiTinhModel.fromJson(Map<String, dynamic> json) {
    key = json['key'].toString();
    value = json['value'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (key != null) data['key'] = key;

    // check null idTaiKhoan
    if (value != null) data['value'] = value;

    return data;
  }

  @override
  String toString() {
    return value!;
  }
}
