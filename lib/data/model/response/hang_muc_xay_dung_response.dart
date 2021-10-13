
class HangMucXayDungResponse {
  String? id;
  String? tieuDe;
  String? hinhAnh;

  String? createdAt;
  String? updatedAt;

  HangMucXayDungResponse({
      this.id,
      this.tieuDe,
      this.hinhAnh,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  HangMucXayDungResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    hinhAnh = json['hinhAnh'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null hinhAnh
    if (hinhAnh != null) data['hinhAnh'] = hinhAnh; 


    return data;
  }
}
