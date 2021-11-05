class ThongTinThueRequest {
  String? id;
  String? gioiThieu;
  String? dangKyThue;
  String? camKetThue;
  String? loai;

  ThongTinThueRequest({
      this.id,
      this.gioiThieu,
      this.dangKyThue,
      this.camKetThue,
      this.loai});
  
  ///
  /// From JSON
  ///
  ThongTinThueRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    gioiThieu = json['gioiThieu'].toString();
    dangKyThue = json['dangKyThue'].toString();
    camKetThue = json['camKetThue'].toString();
    loai = json['loai'].toString();
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
