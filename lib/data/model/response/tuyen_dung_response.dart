import 'chuyen_nganh_phu_response.dart';
import 'tai_khoan_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'hinh_thuc_lam_viec_response.dart';
import 'trinh_do_hoc_van_response.dart';
import 'chuyen_nganh_chinh_response.dart';
import 'so_nam_kinh_nghiem_response.dart';
import 'muc_luong_du_kien_response.dart';
import 'thoi_gian_lam_viec_response.dart';
import 'bang_gia_dang_tin_response.dart';
import 'bang_gia_loc_ho_so_response.dart';
import 'hinh_thuc_thanh_toan_response.dart';
import 'trang_thai_don_hang_response.dart';

class TuyenDungResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? tieuDe;
  String? congTy;
  String? diaChi;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? gioiTinh;
  String? soLuong;
  HinhThucLamViecResponse? idHinhThucLamViec;
  TrinhDoHocVanResponse? idTrinhDoHocVan;
  ChuyenNganhChinhResponse? idChuyenNganhChinh;
  SoNamKinhNghiemResponse? idSoNamKinhNghiem;
  MucLuongDuKienResponse? idMucLuongDuKien;
  TinhTpResponse? idNoiLamViec;
  ThoiGianLamViecResponse? idThoiGianLamViec;
  String? moTaCongViec;
  String? yeuCauCongViec;
  String? quyenLoi;
  String? uuTien;
  String? hanNopHoSo;
  String? hoTenLienHe;
  String? soDienThoaiLienHe;
  String? diaChiLienHe;
  String? emailLienHe;
  BangGiaDangTinResponse? idBangGiaDangTin;
  BangGiaLocHoSoResponse? idBangGiaLocHoSo;
  HinhThucThanhToanResponse? idHinhThucThanhToan;
  TrangThaiDonHangResponse? idTrangThaiDonHang;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? phiDichVu;
  String? tienCoc;
  String? idTrangThaiTuyenDung;
  String? thoiGianThuViec;
  String? hinhAnhDaiDien;
  bool? isUngTuyen;

  String? createdAt;
  String? updatedAt;
  List<ChuyenNganhPhuResponse>? idChuyenNganhPhus;

  TuyenDungResponse(
      {this.id,
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
      this.idNoiLamViec,
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
      this.tongDon,
      this.phiDichVu,
      this.tienCoc,
      this.idTrangThaiTuyenDung,
      this.thoiGianThuViec,
      this.idChuyenNganhPhus,
      this.hinhAnhDaiDien,
      this.isUngTuyen,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  TuyenDungResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    tieuDe = json['tieuDe'].toString();
    congTy = json['congTy'].toString();
    diaChi = json['diaChi'].toString();

    // mapping idTinhTp
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length != 24) {
      idTinhTp =
          TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>);
    } else {
      idTinhTp = null;
    }

    // mapping idQuanHuyen
    if (json['idQuanHuyen'] != null &&
        json['idQuanHuyen'].toString().length != 24) {
      idQuanHuyen = QuanHuyenResponse.fromJson(
          json['idQuanHuyen'] as Map<String, dynamic>);
    } else {
      idQuanHuyen = null;
    }

    // mapping idPhuongXa
    if (json['idPhuongXa'] != null &&
        json['idPhuongXa'].toString().length != 24) {
      idPhuongXa =
          PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>);
    } else {
      idPhuongXa = null;
    }
    gioiTinh = json['gioiTinh'].toString();
    soLuong = json['soLuong'].toString();

    // mapping idHinhThucLamViec
    if (json['idHinhThucLamViec'] != null &&
        json['idHinhThucLamViec'].toString().length != 24) {
      idHinhThucLamViec = HinhThucLamViecResponse.fromJson(
          json['idHinhThucLamViec'] as Map<String, dynamic>);
    } else {
      idHinhThucLamViec = null;
    }

    // mapping idTrinhDoHocVan
    if (json['idTrinhDoHocVan'] != null &&
        json['idTrinhDoHocVan'].toString().length != 24) {
      idTrinhDoHocVan = TrinhDoHocVanResponse.fromJson(
          json['idTrinhDoHocVan'] as Map<String, dynamic>);
    } else {
      idTrinhDoHocVan = null;
    }

    // mapping idChuyenNganhChinh
    if (json['idChuyenNganhChinh'] != null &&
        json['idChuyenNganhChinh'].toString().length != 24) {
      idChuyenNganhChinh = ChuyenNganhChinhResponse.fromJson(
          json['idChuyenNganhChinh'] as Map<String, dynamic>);
    } else {
      idChuyenNganhChinh = null;
    }

    // mapping idSoNamKinhNghiem
    if (json['idSoNamKinhNghiem'] != null &&
        json['idSoNamKinhNghiem'].toString().length != 24) {
      idSoNamKinhNghiem = SoNamKinhNghiemResponse.fromJson(
          json['idSoNamKinhNghiem'] as Map<String, dynamic>);
    } else {
      idSoNamKinhNghiem = null;
    }

    // mapping idMucLuongDuKien
    if (json['idMucLuongDuKien'] != null &&
        json['idMucLuongDuKien'].toString().length != 24) {
      idMucLuongDuKien = MucLuongDuKienResponse.fromJson(
          json['idMucLuongDuKien'] as Map<String, dynamic>);
    } else {
      idMucLuongDuKien = null;
    }
    // mapping idTinhTp
    if (json['idNoiLamViec'] != null &&
        json['idNoiLamViec'].toString().length != 24) {
      idNoiLamViec =
          TinhTpResponse.fromJson(json['idNoiLamViec'] as Map<String, dynamic>);
    } else {
      idNoiLamViec = null;
    }

    // mapping idThoiGianLamViec
    if (json['idThoiGianLamViec'] != null &&
        json['idThoiGianLamViec'].toString().length != 24) {
      idThoiGianLamViec = ThoiGianLamViecResponse.fromJson(
          json['idThoiGianLamViec'] as Map<String, dynamic>);
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
    if (json['idBangGiaDangTin'] != null &&
        json['idBangGiaDangTin'].toString().length != 24) {
      idBangGiaDangTin = BangGiaDangTinResponse.fromJson(
          json['idBangGiaDangTin'] as Map<String, dynamic>);
    } else {
      idBangGiaDangTin = null;
    }

    // mapping idBangGiaLocHoSo
    if (json['idBangGiaLocHoSo'] != null &&
        json['idBangGiaLocHoSo'].toString().length != 24) {
      idBangGiaLocHoSo = BangGiaLocHoSoResponse.fromJson(
          json['idBangGiaLocHoSo'] as Map<String, dynamic>);
    } else {
      idBangGiaLocHoSo = null;
    }

    // mapping idHinhThucThanhToan
    if (json['idHinhThucThanhToan'] != null &&
        json['idHinhThucThanhToan'].toString().length != 24) {
      idHinhThucThanhToan = HinhThucThanhToanResponse.fromJson(
          json['idHinhThucThanhToan'] as Map<String, dynamic>);
    } else {
      idHinhThucThanhToan = null;
    }

    // mapping idTrangThaiDonHang
    if (json['idTrangThaiDonHang'] != null &&
        json['idTrangThaiDonHang'].toString().length != 24) {
      idTrangThaiDonHang = TrangThaiDonHangResponse.fromJson(
          json['idTrangThaiDonHang'] as Map<String, dynamic>);
    } else {
      idTrangThaiDonHang = null;
    }
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
    phiDichVu = json['phiDichVu'].toString();
    tienCoc = json['tienCoc'].toString();
    idTrangThaiTuyenDung = json['idTrangThaiTuyenDung'].toString();
    thoiGianThuViec = json['thoiGianThuViec'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();

    // mapping idChuyenNganhPhus
    if (json['idChuyenNganhPhus'] != null &&
        json['idChuyenNganhPhus'].toString().length != 24) {
      idChuyenNganhPhus = [];
      final results = json['idChuyenNganhPhus'] as List<dynamic>;

      for (final element in results) {
        if (element != null && element.toString().length != 24) {
          idChuyenNganhPhus!.add(
              ChuyenNganhPhuResponse.fromJson(element as Map<String, dynamic>));
        }
      }
    } else {
      idChuyenNganhPhus = null;
    }

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null congTy
    if (congTy != null) data['congTy'] = congTy;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null idHinhThucLamViec
    if (idHinhThucLamViec != null)
      data['idHinhThucLamViec'] = idHinhThucLamViec;

    // check null idTrinhDoHocVan
    if (idTrinhDoHocVan != null) data['idTrinhDoHocVan'] = idTrinhDoHocVan;

    // check null idChuyenNganhChinh
    if (idChuyenNganhChinh != null)
      data['idChuyenNganhChinh'] = idChuyenNganhChinh;

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null)
      data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;

    // check null idMucLuongDuKien
    if (idMucLuongDuKien != null) data['idMucLuongDuKien'] = idMucLuongDuKien;

    // check null idNoiLamViec
    if (idNoiLamViec != null) data['idNoiLamViec'] = idNoiLamViec;

    // check null idThoiGianLamViec
    if (idThoiGianLamViec != null)
      data['idThoiGianLamViec'] = idThoiGianLamViec;

    // check null moTaCongViec
    if (moTaCongViec != null) data['moTaCongViec'] = moTaCongViec;

    // check null yeuCauCongViec
    if (yeuCauCongViec != null) data['yeuCauCongViec'] = yeuCauCongViec;

    // check null quyenLoi
    if (quyenLoi != null) data['quyenLoi'] = quyenLoi;

    // check null uuTien
    if (uuTien != null) data['uuTien'] = uuTien;

    // check null hanNopHoSo
    if (hanNopHoSo != null) data['hanNopHoSo'] = hanNopHoSo;

    // check null hoTenLienHe
    if (hoTenLienHe != null) data['hoTenLienHe'] = hoTenLienHe;

    // check null soDienThoaiLienHe
    if (soDienThoaiLienHe != null)
      data['soDienThoaiLienHe'] = soDienThoaiLienHe;

    // check null diaChiLienHe
    if (diaChiLienHe != null) data['diaChiLienHe'] = diaChiLienHe;

    // check null emailLienHe
    if (emailLienHe != null) data['emailLienHe'] = emailLienHe;

    // check null idBangGiaDangTin
    if (idBangGiaDangTin != null) data['idBangGiaDangTin'] = idBangGiaDangTin;

    // check null idBangGiaLocHoSo
    if (idBangGiaLocHoSo != null) data['idBangGiaLocHoSo'] = idBangGiaLocHoSo;

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null)
      data['idHinhThucThanhToan'] = idHinhThucThanhToan;

    // check null idTrangThaiDonHang
    if (idTrangThaiDonHang != null)
      data['idTrangThaiDonHang'] = idTrangThaiDonHang;

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai;

    // check null soTien
    if (soTien != null) data['soTien'] = soTien;

    // check null tongDon
    if (tongDon != null) data['tongDon'] = tongDon;

    // check null phiDichVu
    if (phiDichVu != null) data['phiDichVu'] = phiDichVu;
    // check null thoiGianThuViec
    if (thoiGianThuViec != null) data['thoiGianThuViec'] = thoiGianThuViec;

    // check null idChuyenNganhPhus
    if (idChuyenNganhPhus != null)
      data['idChuyenNganhPhus'] = idChuyenNganhPhus;
    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien;

    // check null tongDon
    if (tienCoc != null) data['tienCoc'] = tienCoc;
    // check null tongDon
    if (isUngTuyen != null) data['isUngTuyen'] = isUngTuyen;

    if (idTrangThaiTuyenDung != null)
      data['idTrangThaiTuyenDung'] = idTrangThaiTuyenDung;

    return data;
  }
}
