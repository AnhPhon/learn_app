import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/trang_thai_du_an_request.dart';
import 'package:template/data/model/response/trang_thai_du_an_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/trang_thai_du_an_repository.dart';

class TrangThaiDuAnProvider {
  TrangThaiDuAnRepository? repository = GetIt.I.get<TrangThaiDuAnRepository>();

  TrangThaiDuAnProvider();

  ///
  /// Get all trangThaiDuAns
  ///
  Future<void> all({
    required Function(List<TrangThaiDuAnResponse> trangThaiDuAns) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDuAnResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert trangThaiDuAn to database
  ///
  Future<void> add({
    required TrangThaiDuAnRequest data,
    required Function(TrangThaiDuAnRequest trangThaiDuAn) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDuAnRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update trangThaiDuAn to database
  ///
  Future<void> update({
    required TrangThaiDuAnRequest data,
    required Function(TrangThaiDuAnRequest trangThaiDuAn) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDuAnRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDuAn to database
  ///
  Future<void> delete({
    required String id,
    required Function(TrangThaiDuAnRequest trangThaiDuAn) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDuAnRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate trangThaiDuAns "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TrangThaiDuAnResponse> trangThaiDuAns) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDuAnResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDuAn to database
  ///
  Future<void> find({
    required String id,
    required Function(TrangThaiDuAnResponse trangThaiDuAn) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDuAnResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
