class DoanhThuDaiLyResponse {
  String? donGia;

  DoanhThuDaiLyResponse(
    this.donGia,
  );

  ///
  /// From JSON
  ///
  DoanhThuDaiLyResponse.fromJson(Map<String, dynamic> json) {
    if (json['donGia'] != null) donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (donGia != null) data['donGia'] = donGia;

    return data;
  }
}
