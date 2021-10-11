import 'tai_khoan_model.dart';
import 'nhom_dich_vu_model.dart';
import 'trang_thai_don_hang_model.dart';
import 'hinh_thuc_thanh_toan_model.dart';
import 'trang_thai_thanh_toan_model.dart';
import 'thoi_gian_lam_viec_model.dart';
import 'tinh_tp_model.dart';
import 'quan_huyen_model.dart';
import 'phuong_xa_model.dart';
import 'bang_gia_don_hang_model.dart';
import 'thong_so_ky_thuat_model.dart';

class DonDichVuModel {
  TaiKhoanModel? idTaiKhoan;
  NhomDichVuModel? idNhomDichVu;
  String? tieuDe;
  String? moTa;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? hinhAnhBanKhoiLuong;
  String? hinhAnhBanVe;
  TrangThaiDonHangModel? idTrangThaiDonHang;
  HinhThucThanhToanModel? idHinhThucThanhToan;
  TrangThaiThanhToanModel? idTrangThaiThanhToan;
  ThoiGianLamViecModel? idThoiGianLamViec;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? giaTriKhachDeXuat;
  String? hinhAnhChiTiet;
  String? moTaChiTiet;
  String? file;
  String? soLuongYeuCau;
  String? soNgay;
  String? diaDiemLamViec;
  BangGiaDonHangModel? idBangGiaDonHang;
  String? gioiTinh;
  ThongSoKyThuatModel? idThongSoKyThuat;
  String? diaDiemBocHang;
  String? diaDiemTraHang;
  String? cuLyVanChuyen;
  String? beRongDiemNhan;
  String? beRongDiemTra;
  String? hinhAnhBaoGia;
  String? phiDichVu;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? taiKhoanNhanDon;
  String? tienCoc;

  DonDichVuModel({
      this.idTaiKhoan,
      this.idNhomDichVu,
      this.tieuDe,
      this.moTa,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hinhAnhBanKhoiLuong,
      this.hinhAnhBanVe,
      this.idTrangThaiDonHang,
      this.idHinhThucThanhToan,
      this.idTrangThaiThanhToan,
      this.idThoiGianLamViec,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.giaTriKhachDeXuat,
      this.hinhAnhChiTiet,
      this.moTaChiTiet,
      this.file,
      this.soLuongYeuCau,
      this.soNgay,
      this.diaDiemLamViec,
      this.idBangGiaDonHang,
      this.gioiTinh,
      this.idThongSoKyThuat,
      this.diaDiemBocHang,
      this.diaDiemTraHang,
      this.cuLyVanChuyen,
      this.beRongDiemNhan,
      this.beRongDiemTra,
      this.hinhAnhBaoGia,
      this.phiDichVu,
      this.khuyenMai,
      this.soTien,
      this.tongDon,
      this.taiKhoanNhanDon,
      this.tienCoc});
  
  ///
  /// From JSON
  ///
  DonDichVuModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idNhomDichVu                                                              
    if (json['idNhomDichVu'] != null) {                                                  
      idNhomDichVu = NhomDichVuModel.fromJson(json['idNhomDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhomDichVu = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    moTa = json['moTa'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    hinhAnhBanKhoiLuong = json['hinhAnhBanKhoiLuong'].toString();
    hinhAnhBanVe = json['hinhAnhBanVe'].toString();

    // mapping idTrangThaiDonHang                                                              
    if (json['idTrangThaiDonHang'] != null) {                                                  
      idTrangThaiDonHang = TrangThaiDonHangModel.fromJson(json['idTrangThaiDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiDonHang = null;                                                               
    }                                                                                  

    // mapping idHinhThucThanhToan                                                              
    if (json['idHinhThucThanhToan'] != null) {                                                  
      idHinhThucThanhToan = HinhThucThanhToanModel.fromJson(json['idHinhThucThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idHinhThucThanhToan = null;                                                               
    }                                                                                  

    // mapping idTrangThaiThanhToan                                                              
    if (json['idTrangThaiThanhToan'] != null) {                                                  
      idTrangThaiThanhToan = TrangThaiThanhToanModel.fromJson(json['idTrangThaiThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiThanhToan = null;                                                               
    }                                                                                  

    // mapping idThoiGianLamViec                                                              
    if (json['idThoiGianLamViec'] != null) {                                                  
      idThoiGianLamViec = ThoiGianLamViecModel.fromJson(json['idThoiGianLamViec'] as Map<String, dynamic>); 
    } else {                                                                           
      idThoiGianLamViec = null;                                                               
    }                                                                                  

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
    giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();
    hinhAnhChiTiet = json['hinhAnhChiTiet'].toString();
    moTaChiTiet = json['moTaChiTiet'].toString();
    file = json['file'].toString();
    soLuongYeuCau = json['soLuongYeuCau'].toString();
    soNgay = json['soNgay'].toString();
    diaDiemLamViec = json['diaDiemLamViec'].toString();

    // mapping idBangGiaDonHang                                                              
    if (json['idBangGiaDonHang'] != null) {                                                  
      idBangGiaDonHang = BangGiaDonHangModel.fromJson(json['idBangGiaDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangGiaDonHang = null;                                                               
    }                                                                                  
    gioiTinh = json['gioiTinh'].toString();

    // mapping idThongSoKyThuat                                                              
    if (json['idThongSoKyThuat'] != null) {                                                  
      idThongSoKyThuat = ThongSoKyThuatModel.fromJson(json['idThongSoKyThuat'] as Map<String, dynamic>); 
    } else {                                                                           
      idThongSoKyThuat = null;                                                               
    }                                                                                  
    diaDiemBocHang = json['diaDiemBocHang'].toString();
    diaDiemTraHang = json['diaDiemTraHang'].toString();
    cuLyVanChuyen = json['cuLyVanChuyen'].toString();
    beRongDiemNhan = json['beRongDiemNhan'].toString();
    beRongDiemTra = json['beRongDiemTra'].toString();
    hinhAnhBaoGia = json['hinhAnhBaoGia'].toString();
    phiDichVu = json['phiDichVu'].toString();
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    tienCoc = json['tienCoc'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['idNhomDichVu'] = idNhomDichVu;
    data['tieuDe'] = tieuDe;
    data['moTa'] = moTa;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['hinhAnhBanKhoiLuong'] = hinhAnhBanKhoiLuong;
    data['hinhAnhBanVe'] = hinhAnhBanVe;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;
    data['idThoiGianLamViec'] = idThoiGianLamViec;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['giaTriKhachDeXuat'] = giaTriKhachDeXuat;
    data['hinhAnhChiTiet'] = hinhAnhChiTiet;
    data['moTaChiTiet'] = moTaChiTiet;
    data['file'] = file;
    data['soLuongYeuCau'] = soLuongYeuCau;
    data['soNgay'] = soNgay;
    data['diaDiemLamViec'] = diaDiemLamViec;
    data['idBangGiaDonHang'] = idBangGiaDonHang;
    data['gioiTinh'] = gioiTinh;
    data['idThongSoKyThuat'] = idThongSoKyThuat;
    data['diaDiemBocHang'] = diaDiemBocHang;
    data['diaDiemTraHang'] = diaDiemTraHang;
    data['cuLyVanChuyen'] = cuLyVanChuyen;
    data['beRongDiemNhan'] = beRongDiemNhan;
    data['beRongDiemTra'] = beRongDiemTra;
    data['hinhAnhBaoGia'] = hinhAnhBaoGia;
    data['phiDichVu'] = phiDichVu;
    data['khuyenMai'] = khuyenMai;
    data['soTien'] = soTien;
    data['tongDon'] = tongDon;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['tienCoc'] = tienCoc;
    return data;
  }
}
