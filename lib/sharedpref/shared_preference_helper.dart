import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------

  // Login: ----------------------------------------------------------
  Future<bool?> get isLogin async {
    return _sharedPreference.getBool(Preferences.isLogin);
  }

  Future<bool> saveIsLogin({required bool id}) async {
    return _sharedPreference.setBool(Preferences.isLogin, id);
  }

  Future<bool> removeIsLogin() async {
    return _sharedPreference.remove(Preferences.isLogin);
  }

  // First: ----------------------------------------------------------
  Future<bool?> get isFirst async {
    return _sharedPreference.getBool(Preferences.isFirst);
  }

  Future<bool> saveIsFirst({required bool id}) async {
    return _sharedPreference.setBool(Preferences.isFirst, id);
  }

  Future<bool> removeIsFirst() async {
    return _sharedPreference.remove(Preferences.isFirst);
  }

  // General Methods: Access token
  Future<String?> get jwtToken async {
    return _sharedPreference.getString(Preferences.jwt_token);
  }

  Future<bool> saveJwtToken(String authToken) async {
    return _sharedPreference.setString(Preferences.jwt_token, authToken);
  }

  Future<bool> removeJwtToken() async {
    return _sharedPreference.remove(Preferences.jwt_token);
  }

  bool containsKey() {
    return _sharedPreference.containsKey(Preferences.jwt_token);
  }

  // General Methods: refresh token
  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refresh);
  }

  Future<bool> saveRefreshToken(String refresh) async {
    return _sharedPreference.setString(Preferences.refresh, refresh);
  }

  Future<bool> removeRefreshToken() async {
    return _sharedPreference.remove(Preferences.refresh);
  }

  // General Methods: username
  Future<String?> get username async {
    return _sharedPreference.getString(Preferences.username);
  }

  Future<bool> saveUsername(String username) async {
    return _sharedPreference.setString(Preferences.username, username);
  }

  Future<bool> removeUsername() async {
    return _sharedPreference.remove(Preferences.username);
  }

  // General Methods: Password
  Future<String?> get password async {
    return _sharedPreference.getString(Preferences.password);
  }

  Future<bool> savePassword(String password) async {
    return _sharedPreference.setString(Preferences.password, password);
  }

  Future<bool> removePassword() async {
    return _sharedPreference.remove(Preferences.password);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark({required bool value}) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

  // Order: ----------------------------------------------------------
  Future<String?> get orderId async {
    return _sharedPreference.getString(Preferences.orderId);
  }

  Future<bool> saveOrderId(String id) async {
    return _sharedPreference.setString(Preferences.orderId, id);
  }

  Future<bool> removeOrderId() async {
    return _sharedPreference.remove(Preferences.orderId);
  }

  // user: ----------------------------------------------------------
  Future<String?> get userId async {
    return _sharedPreference.getString(Preferences.userId);
  }

  Future<bool> saveUserId(String id) async {
    return _sharedPreference.setString(Preferences.userId, id);
  }

  Future<bool> removeUserId() async {
    return _sharedPreference.remove(Preferences.userId);
  }

  // ProvinceId: ----------------------------------------------------------
  Future<String?> get provinceId async {
    return _sharedPreference.getString(Preferences.province_id);
  }

  Future<bool> saveProvinceId(String id) async {
    return _sharedPreference.setString(Preferences.province_id, id);
  }

  Future<bool> removeProvinceId() async {
    return _sharedPreference.remove(Preferences.province_id);
  }

  // DistrictId: ----------------------------------------------------------
  Future<String?> get districtId async {
    return _sharedPreference.getString(Preferences.district_id);
  }

  Future<bool> saveDistrictId(String id) async {
    return _sharedPreference.setString(Preferences.district_id, id);
  }

  Future<bool> removeDistrictId() async {
    return _sharedPreference.remove(Preferences.district_id);
  }

  // Address: ----------------------------------------------------------
  Future<String?> get address async {
    return _sharedPreference.getString(Preferences.address);
  }

  Future<bool> saveAddress(String id) async {
    return _sharedPreference.setString(Preferences.address, id);
  }

  // Address: ----------------------------------------------------------
  Future<String?> get ward async {
    return _sharedPreference.getString(Preferences.ward);
  }

  Future<bool> saveWard(String id) async {
    return _sharedPreference.setString(Preferences.ward, id);
  }

  // workFlowId: ----------------------------------------------------------
  Future<String?> get workFlowId async {
    return _sharedPreference.getString(Preferences.workFlowId);
  }

  Future<bool> saveWorkFlow({required String id}) async {
    return _sharedPreference.setString(Preferences.workFlowId, id);
  }

  Future<bool> removeWorkFlow() async {
    return _sharedPreference.remove(Preferences.workFlowId);
  }

  //  : ----------------------------------------------------------
  Future<String?> get idTinTuc async {
    return _sharedPreference.getString(Preferences.idTinTuc);
  }

  Future<bool> saveTinTuc({required String id}) async {
    return _sharedPreference.setString(Preferences.idTinTuc, id);
  }

  Future<bool> removeTinTuc() async {
    return _sharedPreference.remove(Preferences.idTinTuc);
  }

  //  : ----------------------------------------------------------
  Future<String?> get idSanPham async {
    return _sharedPreference.getString(Preferences.idSanPham);
  }

  Future<bool> saveSanPham({required String id}) async {
    return _sharedPreference.setString(Preferences.idSanPham, id);
  }

  Future<bool> removeSanPham() async {
    return _sharedPreference.remove(Preferences.idSanPham);
  }

  //  : ----------------------------------------------------------
  Future<String?> get chamcong async {
    return _sharedPreference.getString(Preferences.isChamCong);
  }

  Future<bool> saveChamCongId(String id) async {
    return _sharedPreference.setString(Preferences.isChamCong, id);
  }

  Future<bool> removeChamCongId() async {
    return _sharedPreference.remove(Preferences.isChamCong);
  }

  Future<String?> get duAnNhanVien async {
    return _sharedPreference.getString(Preferences.idDuAn);
  }

  Future<bool> saveIdDuAnNhanVien(String id) async {
    return _sharedPreference.setString(Preferences.idDuAn, id);
  }

  Future<bool> removeIdDuAnNhanVien() async {
    return _sharedPreference.remove(Preferences.idDuAn);
  }

  //  : ----------------------------------------------------------
  Future<String?> get productCategoryId async {
    return _sharedPreference.getString(Preferences.productCategoryId);
  }

  Future<bool> saveProductCategoryId(String id) async {
    return _sharedPreference.setString(Preferences.productCategoryId, id);
  }

  Future<bool> removeProductCategoryId() async {
    return _sharedPreference.remove(Preferences.productCategoryId);
  }

  //  : ----------------------------------------------------------
  Future<String?> get productId async {
    return _sharedPreference.getString(Preferences.productId);
  }

  Future<bool> saveProductId(String id) async {
    return _sharedPreference.setString(Preferences.productId, id);
  }

  Future<bool> removeProductId() async {
    return _sharedPreference.remove(Preferences.productId);
  }

  //  : ----------------------------------------------------------
  Future<String?> get phanHoiDonDichVuId async {
    return _sharedPreference.getString(Preferences.phanHoiDonDichVuId);
  }

  Future<bool> savePhanHoiDonDichVuId(String id) async {
    return _sharedPreference.setString(Preferences.phanHoiDonDichVuId, id);
  }

  Future<bool> removePhanHoiDonDichVuId() async {
    return _sharedPreference.remove(Preferences.phanHoiDonDichVuId);
  }

  // giaTriDonHang : -----------------------------------------------
  Future<double?> get giaTriDonHang async {
    return _sharedPreference.getDouble(Preferences.giaTriDonHang);
  }

  Future<bool> saveGiaTriDonHang(double tongTien) async {
    return _sharedPreference.setDouble(Preferences.giaTriDonHang, tongTien);
  }

  Future<bool> removeGiaTriDonHang() async {
    return _sharedPreference.remove(Preferences.giaTriDonHang);
  }

  // Tiến độ công việc: MỚI TẠO : -----------------------------------------------
  Future<String?> get idNewWork async {
    return _sharedPreference.getString(Preferences.idNewWork);
  }

  Future<bool> saveIdNewWork({required String id}) async {
    return _sharedPreference.setString(Preferences.idNewWork, id);
  }

  Future<bool> removeIdNewWork() async {
    return _sharedPreference.remove(Preferences.idNewWork);
  }
}
