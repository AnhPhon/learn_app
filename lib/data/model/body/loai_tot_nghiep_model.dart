class LoaiTotNghiepModel {
  String? tieuDe;

  LoaiTotNghiepModel({
      this.tieuDe
      });

  LoaiTotNghiepModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    return data;
  }
}
