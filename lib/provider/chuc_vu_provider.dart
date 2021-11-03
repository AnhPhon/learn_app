import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chuc_vu_request.dart';
import 'package:template/data/model/response/chuc_vu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/chuc_vu_repository.dart';

class ChucVuProvider {
  ChucVuRepository? repository = GetIt.I.get<ChucVuRepository>();

  ChucVuProvider();

  ///
  /// Get all chucVus
  ///
  Future<void> all({
    required Function(List<ChucVuResponse> chucVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ChucVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert chucVu to database
  ///
  Future<void> add({
    required ChucVuRequest data,
    required Function(ChucVuRequest chucVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChucVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update chucVu to database
  ///
  Future<void> update({
    required ChucVuRequest data,
    required Function(ChucVuRequest chucVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChucVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chucVu to database
  ///
  Future<void> delete({
    required String id,
    required Function(ChucVuRequest chucVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChucVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate chucVus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ChucVuResponse> chucVus) onSuccess,
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
          .map((e) => ChucVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chucVu to database
  ///
  Future<void> find({
    required String id,
    required Function(ChucVuResponse chucVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChucVuResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
