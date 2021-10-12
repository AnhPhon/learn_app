
class ChuyenNganhChinhResponse {
  String? id;
  String? tieuDe;

  ChuyenNganhChinhResponse({
      this.id,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  ChuyenNganhChinhResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tieuDe = json['tieuDe'].toString();

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


    return data;
  }
}
