import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/yeu_cau_bao_hanh_request.dart';
import 'package:template/data/model/response/yeu_cau_bao_hanh_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/yeu_cau_bao_hanh_repository.dart';

class YeuCauBaoHanhProvider {
  YeuCauBaoHanhRepository? repository = GetIt.I.get<YeuCauBaoHanhRepository>();

  YeuCauBaoHanhProvider();

  ///
  /// Get all yeuCauBaoHanhs
  ///
  Future<void> all({
    required Function(List<YeuCauBaoHanhResponse> yeuCauBaoHanhs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => YeuCauBaoHanhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert yeuCauBaoHanh to database
  ///
  Future<void> add({
    required YeuCauBaoHanhRequest data,
    required Function(YeuCauBaoHanhRequest yeuCauBaoHanh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(YeuCauBaoHanhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update yeuCauBaoHanh to database
  ///
  Future<void> update({
    required YeuCauBaoHanhRequest data,
    required Function(YeuCauBaoHanhRequest yeuCauBaoHanh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(YeuCauBaoHanhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete yeuCauBaoHanh to database
  ///
  Future<void> delete({
    required String id,
    required Function(YeuCauBaoHanhRequest yeuCauBaoHanh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(YeuCauBaoHanhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate yeuCauBaoHanhs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<YeuCauBaoHanhResponse> yeuCauBaoHanhs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => YeuCauBaoHanhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete yeuCauBaoHanh to database
  ///
  Future<void> find({
    required String id,
    required Function(YeuCauBaoHanhResponse yeuCauBaoHanh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(YeuCauBaoHanhResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
