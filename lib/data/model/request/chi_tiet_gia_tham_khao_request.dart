



class ChiTietGiaThamKhaoRequest {
  String? image;
  String? filePdf;
  String? fileExcel;
  ChiTietGiaThamKhaoRequest({
    this.image,
    this.filePdf,
    this.fileExcel,
  });

  ///
  /// From JSON
  ///
  ChiTietGiaThamKhaoRequest.fromJson(Map<String, dynamic> json) {
    image = (json['image'] == null) ? null : json['image'].toString();

    filePdf = json['filePdf'].toString();
    fileExcel = json['fileExcel'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (image != null) data['image'] = image; 

    // check null idDonDichVu
    if (filePdf != null) data['filePdf'] = filePdf; 

    // check null idVatTu
    if (fileExcel != null) data['fileExcel'] = fileExcel; 

    return data;
  }
}
