class QuanHuyenModel {
  String? idTinhTp;
  String? ten;

  QuanHuyenModel({
      this.idTinhTp,
      this.ten
      });

  QuanHuyenModel.fromJson(Map<String, dynamic> json) {
    idTinhTp = json['idTinhTp'].toString();
    ten = json['ten'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTinhTp'] = idTinhTp;
    data['ten'] = ten;
    return data;
  }
}
