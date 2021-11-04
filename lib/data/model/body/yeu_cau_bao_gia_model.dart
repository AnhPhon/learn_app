class YeuCauBaoGiaModel {
  String? loaiCongTrinh;
  String? tinhThanh;
  String? quan;
  String? phuong;
  String? diaChiCuThe;
  String? from;
  String? to;
  String? title;
  String? tieuDeBaoGia;
  String? loaiHinh;
  String? filepath;
  double? phiGiaoHang;
  List<String>? noiDungYeuCau;
  List<Map<String, dynamic>>? features;
  List<String>? images;
  double? giaTriDonHang;
  List<List<Map<String, dynamic>>>? infoCard;
  bool? isCheck;

  YeuCauBaoGiaModel({
    this.loaiCongTrinh,
    this.tinhThanh,
    this.quan,
    this.phuong,
    this.diaChiCuThe,
    this.from,
    this.to,
    this.title,
    this.noiDungYeuCau,
    this.features,
    this.images,
    this.giaTriDonHang,
    this.infoCard,
    this.isCheck,
    this.tieuDeBaoGia,
    this.loaiHinh,
    this.phiGiaoHang = 0,
    this.filepath,
  });

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null loaiCongTrinh
    if (loaiCongTrinh != null) data['loaiCongTrinh'] = loaiCongTrinh;

    // check null tinhThanh
    if (tinhThanh != null) data['tinhThanh'] = tinhThanh;

    // check null quan
    if (quan != null) data['quan'] = quan;

    // check null phuong
    if (phuong != null) data['phuong'] = phuong;

    // check null diaChiCuThe
    if (diaChiCuThe != null) data['diaChiCuThe'] = diaChiCuThe;

    // check null from
    if (from != null) data['from'] = from;

    // check null to
    if (to != null) data['to'] = to;

    // check null title
    if (title != null) data['title'] = title;

    // check null noiDungYeuCau
    if (noiDungYeuCau != null) data['noiDungYeuCau'] = noiDungYeuCau;

    // check null features
    if (features != null) data['features'] = features;

    // check null images
    if (images != null) data['images'] = images;

    // check null giaTriDonHang
    if (giaTriDonHang != null) data['giaTriDonHang'] = giaTriDonHang;

    // check null infoCard
    if (infoCard != null) data['infoCard'] = infoCard;

    // check null isCheck
    if (isCheck != null) data['isCheck'] = isCheck;

    // check null tieuDeBaoGia
    if (tieuDeBaoGia != null) data['tieuDeBaoGia'] = tieuDeBaoGia;

    // check null loaihinh
    if (loaiHinh != null) data['loaiHinh'] = loaiHinh;

    // check null phiGiaoHang
    if (phiGiaoHang != null) data['phiGiaoHang'] = phiGiaoHang;

    // check null filepath
    if (filepath != null) data['filepath'] = filepath;

    return data;
  }
}
