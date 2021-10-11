
class VatTuModel {
  String? tenVatTu;
  String? quyCach;
  String? donVi;
  String? donGia;

  VatTuModel({
      this.tenVatTu,
      this.quyCach,
      this.donVi,
      this.donGia});
  
  ///
  /// From JSON
  ///
  VatTuModel.fromJson(Map<String, dynamic> json) {
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
    // check null tenVatTu
    if (tenVatTu != null) data['tenVatTu'] = tenVatTu; 

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach; 

    // check null donVi
    if (donVi != null) data['donVi'] = donVi; 

    // check null donGia
    if (donGia != null) data['donGia'] = donGia; 


    return data;
  }
}
