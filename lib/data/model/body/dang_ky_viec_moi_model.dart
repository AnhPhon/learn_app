import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/request/tin_hoc_request.dart';
import 'package:template/data/model/response/ke_khai_kinh_nghiem_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';

class DangKyViecMoiModel {
  int lengthBangBangCap;
  bool? tuyenDung;
  String? tieuDe;
  String? tenUngVien;
  String? gioiTinh;
  String? ngaySinh;
  String? dienThoai;
  String? email;
  String? choOHienTai;
  String? honNhan;
  String? hinhThucLamViec;
  String? hinhThucLamViecLabel;
  String? mucTieuNgheNghiep;
  String? phanMemHoTro;
  String? soThichTheHienTrinhDo;
  String? soThichTheHienKyNang;
  String? soThichTheHienTinhCach;
  List<BangBangCapRequest>? bangBangCaps;
  List<KeKhaiKinhNghiemResponse>? keKhaiKinhNghiems;
  List<NgoaiNguResponse>? ngoaiNguList;
  TinHocRequest? tinHoc;
  String? kyNangSoTruong;
  List<String>? anhHoSoXinViecs;
  String? maSoHoSo;
  List<dynamic>? idBangBangCap;

  List<dynamic>? idKeKhaiKinhNghiems;
  List<dynamic>? idNgoaiNgu;
  String? idTinHoc;
  List<String>? anhBangCaps;

  List<dynamic>? idNganhNgheMongMuons;
  List<dynamic>? idNoiLamViecs;

  String? chucVuHienTai;
  String? chucVuMongMuon;
  String? idSoNamKinhNghiem;
  List<String?>? noiLamViec;
  MucLuongDuKienResponse? mucLuongDeXuat;
  String? namKinhNghiem;
  List<LoaiCongViecResponse?>? nghanhNgheMongMuon;

  String? fileHoSoXinViec;

  List<String>? anhBangCapsList;

  TinhTpResponse? tinhTpResponse;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;

  //Tham khảo
  String? nguoiThamKhao;
  String? chucDanh;
  String? congTy;
  String? soDienThoai;
  String? emailThamKhao;

  //
  String? idNhomDichVu;
  String? idLoaiConViec;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? soLuong;
  String? isCheckHCM;
  String? quanHuyenHoChiMinh;
  String? phuongXaHoChiMinh;
  String? isCheckHN;
  String? quanHuyenHaNoi;
  String? phuongXaHaNoi;
  String? isCheckDN;
  String? quanHuyenDaNang;
  String? phuongXaDaNang;
  String? isCheckTinhTPKhac;
  String? tinhTpKhac;
  String? quanHuyenKhac;
  String? phuongXaKhac;
  List<String?>? listDiaDiemKhac;

  bool? isFirstRegister7Group;

  DangKyViecMoiModel({
    this.isFirstRegister7Group,
    this.tinhTpResponse,
    this.quanHuyenResponse,
    this.phuongXaResponse,
    this.chucVuHienTai,
    this.chucVuMongMuon,
    this.idSoNamKinhNghiem,
    this.noiLamViec,
    this.mucLuongDeXuat,
    this.tieuDe,
    this.tenUngVien,
    this.gioiTinh,
    this.ngaySinh,
    this.dienThoai,
    this.email,
    this.hinhThucLamViecLabel,
    this.choOHienTai,
    this.honNhan,
    this.idNoiLamViecs,
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
    this.kyNangSoTruong,
    this.anhHoSoXinViecs,
    this.idBangBangCap,
    this.anhBangCaps,
    this.idKeKhaiKinhNghiems,
    this.idNganhNgheMongMuons,
    this.idNgoaiNgu,
    this.idTinHoc,
    this.fileHoSoXinViec,
    this.anhBangCapsList,
    this.maSoHoSo,
    required this.lengthBangBangCap,
    this.nghanhNgheMongMuon,
    this.namKinhNghiem,

    //Tham khảo
    this.nguoiThamKhao,
    this.chucDanh,
    this.congTy,
    this.soDienThoai,
    this.emailThamKhao,
    this.idNhomDichVu,
    this.idLoaiConViec,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.soLuong,
    this.isCheckHCM,
    this.quanHuyenHoChiMinh,
    this.phuongXaHoChiMinh,
    this.isCheckHN,
    this.quanHuyenHaNoi,
    this.phuongXaHaNoi,
    this.isCheckDN,
    this.quanHuyenDaNang,
    this.phuongXaDaNang,
    this.isCheckTinhTPKhac,
    this.tinhTpKhac,
    this.quanHuyenKhac,
    this.phuongXaKhac,
    this.listDiaDiemKhac,
  });
}
