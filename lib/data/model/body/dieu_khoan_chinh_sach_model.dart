class DieuKhoanChinhSachModel {
  String? type;
  String? tieuDe;
  String? noiDung;

  DieuKhoanChinhSachModel({
      this.type,
      this.tieuDe,
      this.noiDung
      });

  DieuKhoanChinhSachModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}