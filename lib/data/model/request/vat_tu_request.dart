class VatTuRequest {
  String? id;
  String? tenVatTu;
  String? quyCach;
  String? donVi;

  VatTuRequest({
      this.id,
      this.tenVatTu,
      this.quyCach,
      this.donVi,
      });
  
  ///
  /// From JSON
  ///
  VatTuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tenVatTu = json['tenVatTu'].toString();
    quyCach = json['quyCach'].toString();
    donVi = json['donVi'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null tenVatTu
    if (tenVatTu != null) data['tenVatTu'] = tenVatTu; 

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach; 

    // check null donVi
    if (donVi != null) data['donVi'] = donVi; 




    return data;
  }
}
