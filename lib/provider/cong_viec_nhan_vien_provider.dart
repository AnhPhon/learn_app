import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/cong_viec_nhan_vien_request.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/cong_viec_nhan_vien_repository.dart';

class CongViecNhanVienProvider {
  CongViecNhanVienRepository? repository = GetIt.I.get<CongViecNhanVienRepository>();

  CongViecNhanVienProvider();

  ///
  /// Get all congViecNhanViens
  ///
  Future<void> all({
    required Function(List<CongViecNhanVienResponse> congViecNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => CongViecNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert congViecNhanVien to database
  ///
  Future<void> add({
    required CongViecNhanVienRequest data,
    required Function(CongViecNhanVienRequest congViecNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CongViecNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update congViecNhanVien to database
  ///
  Future<void> update({
    required CongViecNhanVienRequest data,
    required Function(CongViecNhanVienRequest congViecNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CongViecNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete congViecNhanVien to database
  ///
  Future<void> delete({
    required String id,
    required Function(CongViecNhanVienRequest congViecNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CongViecNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate congViecNhanViens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<CongViecNhanVienResponse> congViecNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => CongViecNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete congViecNhanVien to database
  ///
  Future<void> find({
    required String id,
    required Function(CongViecNhanVienResponse congViecNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CongViecNhanVienResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
