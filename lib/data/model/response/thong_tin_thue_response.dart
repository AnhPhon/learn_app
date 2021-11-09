
class ThongTinThueResponse {
  String? id;
  String? gioiThieu;
  String? dangKyThue;
  String? camKetThue;
  String? loai;

  String? createdAt;
  String? updatedAt;

  ThongTinThueResponse({
      this.id,
      this.gioiThieu,
      this.dangKyThue,
      this.camKetThue,
      this.loai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongTinThueResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    gioiThieu = json['gioiThieu'].toString();
    dangKyThue = json['dangKyThue'].toString();
    camKetThue = json['camKetThue'].toString();
    loai = json['loai'].toString();

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

    // check null gioiThieu
    if (gioiThieu != null) data['gioiThieu'] = gioiThieu; 

    // check null dangKyThue
    if (dangKyThue != null) data['dangKyThue'] = dangKyThue; 

    // check null camKetThue
    if (camKetThue != null) data['camKetThue'] = camKetThue; 

    // check null loai
    if (loai != null) data['loai'] = loai; 


    return data;
  }
}
