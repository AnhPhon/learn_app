import 'bang_gia_dang_tin_model.dart';
import 'bang_gia_loc_ho_so_model.dart';
import 'chuyen_nganh_chinh_model.dart';
import 'hinh_thuc_lam_viec_model.dart';
import 'hinh_thuc_thanh_toan_model.dart';
import 'muc_luong_du_kien_model.dart';
import 'phuong_xa_model.dart';
import 'quan_huyen_model.dart';
import 'so_nam_kinh_nghiem_model.dart';
import 'tai_khoan_model.dart';
import 'thoi_gian_lam_viec_model.dart';
import 'tinh_tp_model.dart';
import 'trang_thai_don_hang_model.dart';
import 'trinh_do_hoc_van_model.dart';

class TuyenDungModel {
  TaiKhoanModel? idTaiKhoan;
  String? tieuDe;
  String? congTy;
  String? diaChi;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? gioiTinh;
  String? soLuong;
  HinhThucLamViecModel? idHinhThucLamViec;
  TrinhDoHocVanModel? idTrinhDoHocVan;
  ChuyenNganhChinhModel? idChuyenNganhChinh;
  SoNamKinhNghiemModel? idSoNamKinhNghiem;
  MucLuongDuKienModel? idMucLuongDuKien;
  String? noiLamViec;
  ThoiGianLamViecModel? idThoiGianLamViec;
  String? moTaCongViec;
  String? yeuCauCongViec;
  String? quyenLoi;
  String? uuTien;
  String? hanNopHoSo;
  String? hoTenLienHe;
  String? soDienThoaiLienHe;
  String? diaChiLienHe;
  String? emailLienHe;
  BangGiaDangTinModel? idBangGiaDangTin;
  BangGiaLocHoSoModel? idBangGiaLocHoSo;
  HinhThucThanhToanModel? idHinhThucThanhToan;
  TrangThaiDonHangModel? idTrangThaiDonHang;
  String? khuyenMai;
  String? soTien;
  String? tongDon;

  TuyenDungModel({
      this.idTaiKhoan,
      this.tieuDe,
      this.congTy,
      this.diaChi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.gioiTinh,
      this.soLuong,
      this.idHinhThucLamViec,
      this.idTrinhDoHocVan,
      this.idChuyenNganhChinh,
      this.idSoNamKinhNghiem,
      this.idMucLuongDuKien,
      this.noiLamViec,
      this.idThoiGianLamViec,
      this.moTaCongViec,
      this.yeuCauCongViec,
      this.quyenLoi,
      this.uuTien,
      this.hanNopHoSo,
      this.hoTenLienHe,
      this.soDienThoaiLienHe,
      this.diaChiLienHe,
      this.emailLienHe,
      this.idBangGiaDangTin,
      this.idBangGiaLocHoSo,
      this.idHinhThucThanhToan,
      this.idTrangThaiDonHang,
      this.khuyenMai,
      this.soTien,
      this.tongDon});
  
  ///
  /// From JSON
  ///
  TuyenDungModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    congTy = json['congTy'].toString();
    diaChi = json['diaChi'].toString();

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null) {                                                  
      idTinhTp = TinhTpModel.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null) {                                                  
      idQuanHuyen = QuanHuyenModel.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null) {                                                  
      idPhuongXa = PhuongXaModel.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    gioiTinh = json['gioiTinh'].toString();
    soLuong = json['soLuong'].toString();

    // mapping idHinhThucLamViec                                                              
    if (json['idHinhThucLamViec'] != null) {                                                  
      idHinhThucLamViec = HinhThucLamViecModel.fromJson(json['idHinhThucLamViec'] as Map<String, dynamic>); 
    } else {                                                                           
      idHinhThucLamViec = null;                                                               
    }                                                                                  

    // mapping idTrinhDoHocVan                                                              
    if (json['idTrinhDoHocVan'] != null) {                                                  
      idTrinhDoHocVan = TrinhDoHocVanModel.fromJson(json['idTrinhDoHocVan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrinhDoHocVan = null;                                                               
    }                                                                                  

    // mapping idChuyenNganhChinh                                                              
    if (json['idChuyenNganhChinh'] != null) {                                                  
      idChuyenNganhChinh = ChuyenNganhChinhModel.fromJson(json['idChuyenNganhChinh'] as Map<String, dynamic>); 
    } else {                                                                           
      idChuyenNganhChinh = null;                                                               
    }                                                                                  

    // mapping idSoNamKinhNghiem                                                              
    if (json['idSoNamKinhNghiem'] != null) {                                                  
      idSoNamKinhNghiem = SoNamKinhNghiemModel.fromJson(json['idSoNamKinhNghiem'] as Map<String, dynamic>); 
    } else {                                                                           
      idSoNamKinhNghiem = null;                                                               
    }                                                                                  

    // mapping idMucLuongDuKien                                                              
    if (json['idMucLuongDuKien'] != null) {                                                  
      idMucLuongDuKien = MucLuongDuKienModel.fromJson(json['idMucLuongDuKien'] as Map<String, dynamic>); 
    } else {                                                                           
      idMucLuongDuKien = null;                                                               
    }                                                                                  
    noiLamViec = json['noiLamViec'].toString();

    // mapping idThoiGianLamViec                                                              
    if (json['idThoiGianLamViec'] != null) {                                                  
      idThoiGianLamViec = ThoiGianLamViecModel.fromJson(json['idThoiGianLamViec'] as Map<String, dynamic>); 
    } else {                                                                           
      idThoiGianLamViec = null;                                                               
    }                                                                                  
    moTaCongViec = json['moTaCongViec'].toString();
    yeuCauCongViec = json['yeuCauCongViec'].toString();
    quyenLoi = json['quyenLoi'].toString();
    uuTien = json['uuTien'].toString();
    hanNopHoSo = json['hanNopHoSo'].toString();
    hoTenLienHe = json['hoTenLienHe'].toString();
    soDienThoaiLienHe = json['soDienThoaiLienHe'].toString();
    diaChiLienHe = json['diaChiLienHe'].toString();
    emailLienHe = json['emailLienHe'].toString();

    // mapping idBangGiaDangTin                                                              
    if (json['idBangGiaDangTin'] != null) {                                                  
      idBangGiaDangTin = BangGiaDangTinModel.fromJson(json['idBangGiaDangTin'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangGiaDangTin = null;                                                               
    }                                                                                  

    // mapping idBangGiaLocHoSo                                                              
    if (json['idBangGiaLocHoSo'] != null) {                                                  
      idBangGiaLocHoSo = BangGiaLocHoSoModel.fromJson(json['idBangGiaLocHoSo'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangGiaLocHoSo = null;                                                               
    }                                                                                  

    // mapping idHinhThucThanhToan                                                              
    if (json['idHinhThucThanhToan'] != null) {                                                  
      idHinhThucThanhToan = HinhThucThanhToanModel.fromJson(json['idHinhThucThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idHinhThucThanhToan = null;                                                               
    }                                                                                  

    // mapping idTrangThaiDonHang                                                              
    if (json['idTrangThaiDonHang'] != null) {                                                  
      idTrangThaiDonHang = TrangThaiDonHangModel.fromJson(json['idTrangThaiDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiDonHang = null;                                                               
    }                                                                                  
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    data['congTy'] = congTy;
    data['diaChi'] = diaChi;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['gioiTinh'] = gioiTinh;
    data['soLuong'] = soLuong;
    data['idHinhThucLamViec'] = idHinhThucLamViec;
    data['idTrinhDoHocVan'] = idTrinhDoHocVan;
    data['idChuyenNganhChinh'] = idChuyenNganhChinh;
    data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;
    data['idMucLuongDuKien'] = idMucLuongDuKien;
    data['noiLamViec'] = noiLamViec;
    data['idThoiGianLamViec'] = idThoiGianLamViec;
    data['moTaCongViec'] = moTaCongViec;
    data['yeuCauCongViec'] = yeuCauCongViec;
    data['quyenLoi'] = quyenLoi;
    data['uuTien'] = uuTien;
    data['hanNopHoSo'] = hanNopHoSo;
    data['hoTenLienHe'] = hoTenLienHe;
    data['soDienThoaiLienHe'] = soDienThoaiLienHe;
    data['diaChiLienHe'] = diaChiLienHe;
    data['emailLienHe'] = emailLienHe;
    data['idBangGiaDangTin'] = idBangGiaDangTin;
    data['idBangGiaLocHoSo'] = idBangGiaLocHoSo;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['khuyenMai'] = khuyenMai;
    data['soTien'] = soTien;
    data['tongDon'] = tongDon;
    return data;
  }
}
