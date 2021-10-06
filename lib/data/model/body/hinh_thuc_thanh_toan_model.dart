class HinhThucThanhToanModel {
  String? tieuDe;
  String? noiDung;

  HinhThucThanhToanModel({
      this.tieuDe,
      this.noiDung
      });

  HinhThucThanhToanModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}