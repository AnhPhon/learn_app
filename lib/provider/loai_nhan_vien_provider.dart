import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/loai_nhan_vien_request.dart';
import 'package:template/data/model/response/loai_nhan_vien_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/loai_nhan_vien_repository.dart';

class LoaiNhanVienProvider {
  LoaiNhanVienRepository? repository = GetIt.I.get<LoaiNhanVienRepository>();

  LoaiNhanVienProvider();

  ///
  /// Get all loaiNhanViens
  ///
  Future<void> all({
    required Function(List<LoaiNhanVienResponse> loaiNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert loaiNhanVien to database
  ///
  Future<void> add({
    required LoaiNhanVienRequest data,
    required Function(LoaiNhanVienRequest loaiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update loaiNhanVien to database
  ///
  Future<void> update({
    required LoaiNhanVienRequest data,
    required Function(LoaiNhanVienRequest loaiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiNhanVien to database
  ///
  Future<void> delete({
    required String id,
    required Function(LoaiNhanVienRequest loaiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate loaiNhanViens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LoaiNhanVienResponse> loaiNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiNhanVien to database
  ///
  Future<void> find({
    required String id,
    required Function(LoaiNhanVienResponse loaiNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiNhanVienResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
