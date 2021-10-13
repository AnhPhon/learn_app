import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/du_an_nhan_vien_request.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/du_an_nhan_vien_repository.dart';

class DuAnNhanVienProvider {
  DuAnNhanVienRepository? repository = GetIt.I.get<DuAnNhanVienRepository>();

  DuAnNhanVienProvider();

  ///
  /// Get all duAnNhanViens
  ///
  Future<void> all({
    required Function(List<DuAnNhanVienResponse> duAnNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DuAnNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert duAnNhanVien to database
  ///
  Future<void> add({
    required DuAnNhanVienRequest data,
    required Function(DuAnNhanVienRequest duAnNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update duAnNhanVien to database
  ///
  Future<void> update({
    required DuAnNhanVienRequest data,
    required Function(DuAnNhanVienRequest duAnNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete duAnNhanVien to database
  ///
  Future<void> delete({
    required String id,
    required Function(DuAnNhanVienRequest duAnNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnNhanVienRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate duAnNhanViens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DuAnNhanVienResponse> duAnNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DuAnNhanVienResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete duAnNhanVien to database
  ///
  Future<void> find({
    required String id,
    required Function(DuAnNhanVienResponse duAnNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnNhanVienResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
