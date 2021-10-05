import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/danh_sach_ung_tuyen_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';

class DanhSachUngTuyenProvider {
  DanhSachUngTuyenRepository? repository = GetIt.I.get<DanhSachUngTuyenRepository>();

  DanhSachUngTuyenProvider();

  ///
  /// Get all danhSachUngTuyens
  ///
  Future<void> all({
    required Function(List<DanhSachUngTuyenModel> danhSachUngTuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachUngTuyenModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhSachUngTuyen to database
  ///
  Future<void> add({
    required DanhSachUngTuyenModel data,
    required Function(DanhSachUngTuyenModel danhSachUngTuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachUngTuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhSachUngTuyen to database
  ///
  Future<void> update({
    required DanhSachUngTuyenModel data,
    required Function(DanhSachUngTuyenModel danhSachUngTuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachUngTuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachUngTuyen to database
  ///
  Future<void> delete({
    required String id,
    required DanhSachUngTuyenModel data,
    required Function(DanhSachUngTuyenModel danhSachUngTuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachUngTuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachUngTuyens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhSachUngTuyenModel> danhSachUngTuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachUngTuyenModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachUngTuyen to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhSachUngTuyenModel danhSachUngTuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachUngTuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
