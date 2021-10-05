class PhuongXaModel {
  String? idQuanHuyen;
  String? ten;

  PhuongXaModel({
      this.idQuanHuyen,
      this.ten
      });

  PhuongXaModel.fromJson(Map<String, dynamic> json) {
    idQuanHuyen = json['idQuanHuyen'].toString();
    ten = json['ten'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idQuanHuyen'] = idQuanHuyen;
    data['ten'] = ten;
    return data;
  }
}
