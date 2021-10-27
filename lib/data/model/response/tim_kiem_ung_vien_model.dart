class TimKiemUngVienModel {
  String? key;
  String? value;

  TimKiemUngVienModel({
    this.key,
    this.value,
  });

  ///
  /// From JSON
  ///
  TimKiemUngVienModel.fromJson(Map<String, dynamic> json) {
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
}
