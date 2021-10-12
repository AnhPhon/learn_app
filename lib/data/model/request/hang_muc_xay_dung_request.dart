class HangMucXayDungRequest {
  String? id;
  String? tieuDe;
  String? hinhAnh;

  HangMucXayDungRequest({
      this.id,
      this.tieuDe,
      this.hinhAnh});
  
  ///
  /// From JSON
  ///
  HangMucXayDungRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    hinhAnh = json['hinhAnh'].toString();
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
