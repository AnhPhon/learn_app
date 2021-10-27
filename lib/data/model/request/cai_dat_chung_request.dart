class CaiDatChungRequest {
  String? id;
  String? khuyenMai;

  CaiDatChungRequest({
      this.id,
      this.khuyenMai});
  
  ///
  /// From JSON
  ///
  CaiDatChungRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    khuyenMai = json['khuyenMai'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai; 


    return data;
  }
}
