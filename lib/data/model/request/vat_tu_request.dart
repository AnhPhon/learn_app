class VatTuRequest {
  String? id;
  String? tenVatTu;
  String? quyCach;
  String? donVi;
  String? donGia;
  VatTuRequest({
      this.id,
      this.tenVatTu,
      this.quyCach,
      this.donVi,
      this.donGia});
  
  ///
  /// From JSON
  ///
  VatTuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tenVatTu = json['tenVatTu'].toString();
    quyCach = json['quyCach'].toString();
    donVi = json['donVi'].toString();
    donGia = json['donGia'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenVatTu'] = tenVatTu;
    data['quyCach'] = quyCach;
    data['donVi'] = donVi;
    data['donGia'] = donGia;
    return data;
  }
}
