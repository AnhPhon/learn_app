class NhomDichVuRequest {
  String? id;
  String? tenDichVu;
  String? nhomDichVu;

  NhomDichVuRequest({
      this.id,
      this.tenDichVu});
  
  ///
  /// From JSON
  ///
  NhomDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tenDichVu = json['tenDichVu'].toString();
    nhomDichVu = json['nhomDichVu'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tenDichVu
    if (tenDichVu != null) data['tenDichVu'] = tenDichVu; 
    
    // check null nhomDichVu
    if (nhomDichVu != null) data['nhomDichVu'] = nhomDichVu; 


    return data;
  }

  @override
  String toString() {
      return tenDichVu!;
  }
}
