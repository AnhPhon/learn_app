import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/trang_thai_thanh_toan_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/trang_thai_thanh_toan_repository.dart';

class TrangThaiThanhToanProvider {
  TrangThaiThanhToanRepository? repository = GetIt.I.get<TrangThaiThanhToanRepository>();

  TrangThaiThanhToanProvider();

  ///
  /// Get all trangThaiThanhToans
  ///
  Future<void> all({
    required Function(List<TrangThaiThanhToanModel> trangThaiThanhToans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiThanhToanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert trangThaiThanhToan to database
  ///
  Future<void> add({
    required TrangThaiThanhToanModel data,
    required Function(TrangThaiThanhToanModel trangThaiThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update trangThaiThanhToan to database
  ///
  Future<void> update({
    required TrangThaiThanhToanModel data,
    required Function(TrangThaiThanhToanModel trangThaiThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiThanhToan to database
  ///
  Future<void> delete({
    required String id,
    required TrangThaiThanhToanModel data,
    required Function(TrangThaiThanhToanModel trangThaiThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate trangThaiThanhToans "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TrangThaiThanhToanModel> trangThaiThanhToans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => TrangThaiThanhToanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trangThaiThanhToan to database
  ///
  Future<void> find({
    required String id,
    required Function(TrangThaiThanhToanModel trangThaiThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrangThaiThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
