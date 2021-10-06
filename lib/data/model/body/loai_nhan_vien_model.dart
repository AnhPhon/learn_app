class LoaiNhanVienModel {
  String? tieuDe;

  LoaiNhanVienModel({
      this.tieuDe
      });

  LoaiNhanVienModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tieuDe'] = tieuDe;
    return data;
  }
}
