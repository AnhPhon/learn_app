import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';

class DangKyViecMoiProvider {
  DangKyViecMoiRepository? repository = GetIt.I.get<DangKyViecMoiRepository>();

  DangKyViecMoiProvider();

  ///
  /// Get all dangKyViecMois
  ///
  Future<void> all({
    required Function(List<DangKyViecMoiResponse> dangKyViecMois) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DangKyViecMoiResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert dangKyViecMoi to database
  ///
  Future<void> add({
    required DangKyViecMoiRequest data,
    required Function(DangKyViecMoiRequest dangKyViecMoi) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DangKyViecMoiRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update dangKyViecMoi to database
  ///
  Future<void> update({
    required DangKyViecMoiRequest data,
    required Function(DangKyViecMoiRequest dangKyViecMoi) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DangKyViecMoiRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dangKyViecMoi to database
  ///
  Future<void> delete({
    required String id,
    required Function(DangKyViecMoiRequest dangKyViecMoi) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DangKyViecMoiRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate dangKyViecMois "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DangKyViecMoiResponse> dangKyViecMois) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DangKyViecMoiResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dangKyViecMoi to database
  ///
  Future<void> find({
    required String id,
    required Function(DangKyViecMoiResponse dangKyViecMoi) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DangKyViecMoiResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
