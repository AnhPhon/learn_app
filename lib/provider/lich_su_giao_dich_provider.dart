import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/lich_su_giao_dich_request.dart';
import 'package:template/data/model/response/lich_su_giao_dich_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/lich_su_giao_dich_repository.dart';

class LichSuGiaoDichProvider {
  LichSuGiaoDichRepository? repository = GetIt.I.get<LichSuGiaoDichRepository>();

  LichSuGiaoDichProvider();

  ///
  /// Get all lichSuGiaoDichs
  ///
  Future<void> all({
    required Function(List<LichSuGiaoDichResponse> lichSuGiaoDichs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LichSuGiaoDichResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert lichSuGiaoDich to database
  ///
  Future<void> add({
    required LichSuGiaoDichRequest data,
    required Function(LichSuGiaoDichRequest lichSuGiaoDich) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LichSuGiaoDichRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update lichSuGiaoDich to database
  ///
  Future<void> update({
    required LichSuGiaoDichRequest data,
    required Function(LichSuGiaoDichRequest lichSuGiaoDich) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LichSuGiaoDichRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete lichSuGiaoDich to database
  ///
  Future<void> delete({
    required String id,
    required Function(LichSuGiaoDichRequest lichSuGiaoDich) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LichSuGiaoDichRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate lichSuGiaoDichs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LichSuGiaoDichResponse> lichSuGiaoDichs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => LichSuGiaoDichResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete lichSuGiaoDich to database
  ///
  Future<void> find({
    required String id,
    required Function(LichSuGiaoDichResponse lichSuGiaoDich) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LichSuGiaoDichResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
