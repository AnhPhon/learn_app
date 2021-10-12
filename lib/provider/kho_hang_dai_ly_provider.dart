import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/kho_hang_dai_ly_request.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/kho_hang_dai_ly_repository.dart';

class KhoHangDaiLyProvider {
  KhoHangDaiLyRepository? repository = GetIt.I.get<KhoHangDaiLyRepository>();

  KhoHangDaiLyProvider();

  ///
  /// Get all khoHangDaiLys
  ///
  Future<void> all({
    required Function(List<KhoHangDaiLyResponse> khoHangDaiLys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => KhoHangDaiLyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert khoHangDaiLy to database
  ///
  Future<void> add({
    required KhoHangDaiLyRequest data,
    required Function(KhoHangDaiLyRequest khoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update khoHangDaiLy to database
  ///
  Future<void> update({
    required KhoHangDaiLyRequest data,
    required Function(KhoHangDaiLyRequest khoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete khoHangDaiLy to database
  ///
  Future<void> delete({
    required String id,
    required Function(KhoHangDaiLyRequest khoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate khoHangDaiLys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<KhoHangDaiLyResponse> khoHangDaiLys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => KhoHangDaiLyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete khoHangDaiLy to database
  ///
  Future<void> find({
    required String id,
    required Function(KhoHangDaiLyResponse khoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KhoHangDaiLyResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
