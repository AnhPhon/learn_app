class DonViCungCapModel {
  String? tenDonVi;

  DonViCungCapModel({
      this.tenDonVi
      });

  DonViCungCapModel.fromJson(Map<String, dynamic> json) {
    tenDonVi = json['tenDonVi'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenDonVi'] = tenDonVi;
    return data;
  }
}
