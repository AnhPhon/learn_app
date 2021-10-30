import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_luu_tin_tuyen_dung_request.dart';
import 'package:template/data/model/response/danh_sach_luu_tin_tuyen_dung_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_sach_luu_tin_tuyen_dung_repository.dart';

class DanhSachLuuTinTuyenDungProvider {
  DanhSachLuuTinTuyenDungRepository? repository = GetIt.I.get<DanhSachLuuTinTuyenDungRepository>();

  DanhSachLuuTinTuyenDungProvider();

  ///
  /// Get all danhSachLuuTinTuyenDungs
  ///
  Future<void> all({
    required Function(List<DanhSachLuuTinTuyenDungResponse> danhSachLuuTinTuyenDungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachLuuTinTuyenDungResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhSachLuuTinTuyenDung to database
  ///
  Future<void> add({
    required DanhSachLuuTinTuyenDungRequest data,
    required Function(DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachLuuTinTuyenDungRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhSachLuuTinTuyenDung to database
  ///
  Future<void> update({
    required DanhSachLuuTinTuyenDungRequest data,
    required Function(DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachLuuTinTuyenDungRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachLuuTinTuyenDung to database
  ///
  Future<void> delete({
    required String id,
    required Function(DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachLuuTinTuyenDungRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachLuuTinTuyenDungs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhSachLuuTinTuyenDungResponse> danhSachLuuTinTuyenDungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachLuuTinTuyenDungResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachLuuTinTuyenDung to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhSachLuuTinTuyenDungResponse danhSachLuuTinTuyenDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachLuuTinTuyenDungResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
