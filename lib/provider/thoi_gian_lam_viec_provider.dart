import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/thoi_gian_lam_viec_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/thoi_gian_lam_viec_repository.dart';

class ThoiGianLamViecProvider {
  ThoiGianLamViecRepository? repository =
      GetIt.I.get<ThoiGianLamViecRepository>();

  ThoiGianLamViecProvider();

  ///
  /// Get all thoiGianLamViecs
  ///
  Future<void> all({
    required Function(List<ThoiGianLamViecResponse> thoiGianLamViecs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) =>
              ThoiGianLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert thoiGianLamViec to database
  ///
  Future<void> add({
    required ThoiGianLamViecRequest data,
    required Function(ThoiGianLamViecRequest thoiGianLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThoiGianLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update thoiGianLamViec to database
  ///
  Future<void> update({
    required ThoiGianLamViecRequest data,
    required Function(ThoiGianLamViecRequest thoiGianLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThoiGianLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thoiGianLamViec to database
  ///
  Future<void> delete({
    required String id,
    required Function(ThoiGianLamViecRequest thoiGianLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThoiGianLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thoiGianLamViecs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ThoiGianLamViecResponse> thoiGianLamViecs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) =>
              ThoiGianLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thoiGianLamViec to database
  ///
  Future<void> find({
    required String id,
    required Function(ThoiGianLamViecResponse thoiGianLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ThoiGianLamViecResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
