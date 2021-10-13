class TinhTpRequest {
  String? id;
  String? ten;

  TinhTpRequest({
      this.id,
      this.ten});
  
  ///
  /// From JSON
  ///
  TinhTpRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ten = json['ten'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }

  @override
  String toString() {
    return ten!;
  }
}
