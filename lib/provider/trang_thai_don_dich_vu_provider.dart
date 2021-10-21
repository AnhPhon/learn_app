import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/trang_thai_don_dich_vu_request.dart';
import 'package:template/data/model/response/trang_thai_don_dich_vu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/trang_thai_don_dich_vu_repository.dart';

class TrangThaiDonDichVuProvider {
  TrangThaiDonDichVuRepository? repository = GetIt.I.get<TrangThaiDonDichVuRepository>();

  TrangThaiDonDichVuProvider();

  ///
  /// Get all trangThaiDonDichVus
  ///
  Future<void> all({
    required Function(List<TrangThaiDonDichVuResponse> trangThaiDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDonDichVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert trangThaiDonDichVu to database
  ///
  Future<void> add({
    required TrangThaiDonDichVuRequest data,
    required Function(TrangThaiDonDichVuRequest trangThaiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update trangThaiDonDichVu to database
  ///
  Future<void> update({
    required TrangThaiDonDichVuRequest data,
    required Function(TrangThaiDonDichVuRequest trangThaiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDonDichVu to database
  ///
  Future<void> delete({
    required String id,
    required Function(TrangThaiDonDichVuRequest trangThaiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate trangThaiDonDichVus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TrangThaiDonDichVuResponse> trangThaiDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDonDichVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDonDichVu to database
  ///
  Future<void> find({
    required String id,
    required Function(TrangThaiDonDichVuResponse trangThaiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonDichVuResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
