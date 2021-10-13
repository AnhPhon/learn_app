import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/trang_thai_don_hang_request.dart';
import 'package:template/data/model/response/trang_thai_don_hang_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/trang_thai_don_hang_repository.dart';

class TrangThaiDonHangProvider {
  TrangThaiDonHangRepository? repository = GetIt.I.get<TrangThaiDonHangRepository>();

  TrangThaiDonHangProvider();

  ///
  /// Get all trangThaiDonHangs
  ///
  Future<void> all({
    required Function(List<TrangThaiDonHangResponse> trangThaiDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDonHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert trangThaiDonHang to database
  ///
  Future<void> add({
    required TrangThaiDonHangRequest data,
    required Function(TrangThaiDonHangRequest trangThaiDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update trangThaiDonHang to database
  ///
  Future<void> update({
    required TrangThaiDonHangRequest data,
    required Function(TrangThaiDonHangRequest trangThaiDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDonHang to database
  ///
  Future<void> delete({
    required String id,
    required Function(TrangThaiDonHangRequest trangThaiDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate trangThaiDonHangs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TrangThaiDonHangResponse> trangThaiDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiDonHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiDonHang to database
  ///
  Future<void> find({
    required String id,
    required Function(TrangThaiDonHangResponse trangThaiDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiDonHangResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
