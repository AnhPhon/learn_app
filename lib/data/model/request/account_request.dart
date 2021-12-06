class AccountRequest {
  String? soDienThoai;
  String? matKhau;

  AccountRequest({
    this.soDienThoai,
    this.matKhau,
  });

  AccountRequest.fromJson(Map<String, dynamic> json) {
    soDienThoai = json['soDienThoai'].toString();
    matKhau = json['matKhau'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['soDienThoai'] = soDienThoai;
    data['matKhau'] = matKhau;
    return data;
  }
}