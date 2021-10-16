import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/thu_chi_nhan_vien_request.dart';
import 'package:template/data/model/response/thu_chi_nhan_vien_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/thu_chi_nhan_vien_repository.dart';

class ThuChiNhanVienProvider {
  ThuChiNhanVienRepository? repository =
      GetIt.I.get<ThuChiNhanVienRepository>();

  ThuChiNhanVienProvider();

  ///
  /// Get all thuChiNhanViens
  ///
  Future<void> all({
    required Function(List<ThuChiNhanVienResponse> thuChiNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map(
              (e) => ThuChiNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert thuChiNhanVien to database
  ///
  Future<void> add({
    required ThuChiNhanVienRequest data,
    required Function(ThuChiNhanVienRequest thuChiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThuChiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update thuChiNhanVien to database
  ///
  Future<void> update({
    required ThuChiNhanVienRequest data,
    required Function(ThuChiNhanVienRequest thuChiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThuChiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thuChiNhanVien to database
  ///
  Future<void> delete({
    required String id,
    required Function(ThuChiNhanVienRequest thuChiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThuChiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thuChiNhanViens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ThuChiNhanVienResponse> thuChiNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map(
              (e) => ThuChiNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thuChiNhanVien to database
  ///
  Future<void> find({
    required String id,
    required Function(ThuChiNhanVienResponse thuChiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThuChiNhanVienResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
