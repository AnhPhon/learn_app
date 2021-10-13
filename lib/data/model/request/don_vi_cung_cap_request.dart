class DonViCungCapRequest {
  String? id;
  String? tenDonVi;
  DonViCungCapRequest({
      this.id,
      this.tenDonVi});
  
  ///
  /// From JSON
  ///
  DonViCungCapRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenDonVi = json['tenDonVi'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenDonVi'] = tenDonVi;
    return data;
  }
}