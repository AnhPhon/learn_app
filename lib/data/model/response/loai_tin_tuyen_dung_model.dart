class LoaiTinTuyenDungModel {
  String? id;
  String? tieuDe;

  LoaiTinTuyenDungModel({this.id, this.tieuDe});

  LoaiTinTuyenDungModel.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tieuDe = json['tieuDe'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
