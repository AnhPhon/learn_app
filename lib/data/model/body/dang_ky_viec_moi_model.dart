import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/request/ngoai_ngu_request.dart';
import 'package:template/data/model/request/tin_hoc_request.dart';

class DangKyViecMoiModel {
  String? tuyenDung;
  String? tieuDe;
  String? tenUngVien;
  String? gioiTinh;
  String? ngaySinh;
  String? dienThoai;
  String? email;
  String? choOHienTai;
  String? honNhan;
  String? hinhThucLamViec;
  String? mucTieuNgheNghiep;
  String? phanMemHoTro;
  String? soThichTheHienTrinhDo;
  String? soThichTheHienKyNang;
  String? soThichTheHienTinhCach;
  List<BangBangCapRequest>? bangBangCaps;
  List<Map<String, String>>? keKhaiKinhNghiems;
  List<NgoaiNguRequest>? ngoaiNguList;
  TinHocRequest? tinHoc;

  DangKyViecMoiModel({
    this.tieuDe,
    this.tenUngVien,
    this.gioiTinh,
    this.ngaySinh,
    this.dienThoai,
    this.email,
    this.choOHienTai,
    this.honNhan,
    this.hinhThucLamViec,
    this.mucTieuNgheNghiep,
    this.phanMemHoTro,
    this.soThichTheHienTrinhDo,
    this.soThichTheHienKyNang,
    this.soThichTheHienTinhCach,
    this.bangBangCaps,
    this.keKhaiKinhNghiems,
    this.ngoaiNguList,
    this.tinHoc,
    this.tuyenDung,
  });
}
