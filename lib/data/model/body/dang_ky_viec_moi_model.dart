import 'tai_khoan_model.dart';
import 'tinh_tp_model.dart';
import 'quan_huyen_model.dart';
import 'phuong_xa_model.dart';
import 'loai_nhan_vien_model.dart';
import 'bang_bang_cap_model.dart';
import 'so_nam_kinh_nghiem_model.dart';
import 'ke_khai_kinh_nghiem_model.dart';
import 'ngoai_ngu_model.dart';
import 'tin_hoc_model.dart';

class DangKyViecMoiModel {
  TaiKhoanModel? idTaiKhoan;
  String? tieuDe;
  String? tenUngVien;
  String? gioiTinh;
  String? ngaySinh;
  String? email;
  String? diaChi;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? honNhan;
  LoaiNhanVienModel? idLoaiNhanVien;
  String? mucTieuNgheNghiep;
  BangBangCapModel? idBangBangCap;
  String? chucVuHienTai;
  String? chucVuMongMuon;
  SoNamKinhNghiemModel? idSoNamKinhNghiem;
  String? noiLamViec;
  String? mucLuongDeXuat;
  KeKhaiKinhNghiemModel? idKeKhaiKinhNghiem;
  String? anhHoSoXinViec;
  String? fileHoSoXinViec;
  String? kyNangSoTruong;
  NgoaiNguModel? idNgoaiNgu;
  TinHocModel? idTinHoc;

  DangKyViecMoiModel({
      this.idTaiKhoan,
      this.tieuDe,
      this.tenUngVien,
      this.gioiTinh,
      this.ngaySinh,
      this.email,
      this.diaChi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.honNhan,
      this.idLoaiNhanVien,
      this.mucTieuNgheNghiep,
      this.idBangBangCap,
      this.chucVuHienTai,
      this.chucVuMongMuon,
      this.idSoNamKinhNghiem,
      this.noiLamViec,
      this.mucLuongDeXuat,
      this.idKeKhaiKinhNghiem,
      this.anhHoSoXinViec,
      this.fileHoSoXinViec,
      this.kyNangSoTruong,
      this.idNgoaiNgu,
      this.idTinHoc});
  
  ///
  /// From JSON
  ///
  DangKyViecMoiModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    tenUngVien = json['tenUngVien'].toString();
    gioiTinh = json['gioiTinh'].toString();
    ngaySinh = json['ngaySinh'].toString();
    email = json['email'].toString();
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
    honNhan = json['honNhan'].toString();

    // mapping idLoaiNhanVien                                                              
    if (json['idLoaiNhanVien'] != null) {                                                  
      idLoaiNhanVien = LoaiNhanVienModel.fromJson(json['idLoaiNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idLoaiNhanVien = null;                                                               
    }                                                                                  
    mucTieuNgheNghiep = json['mucTieuNgheNghiep'].toString();

    // mapping idBangBangCap                                                              
    if (json['idBangBangCap'] != null) {                                                  
      idBangBangCap = BangBangCapModel.fromJson(json['idBangBangCap'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangBangCap = null;                                                               
    }                                                                                  
    chucVuHienTai = json['chucVuHienTai'].toString();
    chucVuMongMuon = json['chucVuMongMuon'].toString();

    // mapping idSoNamKinhNghiem                                                              
    if (json['idSoNamKinhNghiem'] != null) {                                                  
      idSoNamKinhNghiem = SoNamKinhNghiemModel.fromJson(json['idSoNamKinhNghiem'] as Map<String, dynamic>); 
    } else {                                                                           
      idSoNamKinhNghiem = null;                                                               
    }                                                                                  
    noiLamViec = json['noiLamViec'].toString();
    mucLuongDeXuat = json['mucLuongDeXuat'].toString();

    // mapping idKeKhaiKinhNghiem                                                              
    if (json['idKeKhaiKinhNghiem'] != null) {                                                  
      idKeKhaiKinhNghiem = KeKhaiKinhNghiemModel.fromJson(json['idKeKhaiKinhNghiem'] as Map<String, dynamic>); 
    } else {                                                                           
      idKeKhaiKinhNghiem = null;                                                               
    }                                                                                  
    anhHoSoXinViec = json['anhHoSoXinViec'].toString();
    fileHoSoXinViec = json['fileHoSoXinViec'].toString();
    kyNangSoTruong = json['kyNangSoTruong'].toString();

    // mapping idNgoaiNgu                                                              
    if (json['idNgoaiNgu'] != null) {                                                  
      idNgoaiNgu = NgoaiNguModel.fromJson(json['idNgoaiNgu'] as Map<String, dynamic>); 
    } else {                                                                           
      idNgoaiNgu = null;                                                               
    }                                                                                  

    // mapping idTinHoc                                                              
    if (json['idTinHoc'] != null) {                                                  
      idTinHoc = TinHocModel.fromJson(json['idTinHoc'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinHoc = null;                                                               
    }                                                                                  

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null tenUngVien
    if (tenUngVien != null) data['tenUngVien'] = tenUngVien; 

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh; 

    // check null ngaySinh
    if (ngaySinh != null) data['ngaySinh'] = ngaySinh; 

    // check null email
    if (email != null) data['email'] = email; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null honNhan
    if (honNhan != null) data['honNhan'] = honNhan; 

    // check null idLoaiNhanVien
    if (idLoaiNhanVien != null) data['idLoaiNhanVien'] = idLoaiNhanVien; 

    // check null mucTieuNgheNghiep
    if (mucTieuNgheNghiep != null) data['mucTieuNgheNghiep'] = mucTieuNgheNghiep; 

    // check null idBangBangCap
    if (idBangBangCap != null) data['idBangBangCap'] = idBangBangCap; 

    // check null chucVuHienTai
    if (chucVuHienTai != null) data['chucVuHienTai'] = chucVuHienTai; 

    // check null chucVuMongMuon
    if (chucVuMongMuon != null) data['chucVuMongMuon'] = chucVuMongMuon; 

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null) data['idSoNamKinhNghiem'] = idSoNamKinhNghiem; 

    // check null noiLamViec
    if (noiLamViec != null) data['noiLamViec'] = noiLamViec; 

    // check null mucLuongDeXuat
    if (mucLuongDeXuat != null) data['mucLuongDeXuat'] = mucLuongDeXuat; 

    // check null idKeKhaiKinhNghiem
    if (idKeKhaiKinhNghiem != null) data['idKeKhaiKinhNghiem'] = idKeKhaiKinhNghiem; 

    // check null anhHoSoXinViec
    if (anhHoSoXinViec != null) data['anhHoSoXinViec'] = anhHoSoXinViec; 

    // check null fileHoSoXinViec
    if (fileHoSoXinViec != null) data['fileHoSoXinViec'] = fileHoSoXinViec; 

    // check null kyNangSoTruong
    if (kyNangSoTruong != null) data['kyNangSoTruong'] = kyNangSoTruong; 

    // check null idNgoaiNgu
    if (idNgoaiNgu != null) data['idNgoaiNgu'] = idNgoaiNgu; 

    // check null idTinHoc
    if (idTinHoc != null) data['idTinHoc'] = idTinHoc; 


    return data;
  }
}
