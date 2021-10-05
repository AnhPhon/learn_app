import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/hinh_thuc_thanh_toan_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/hinh_thuc_thanh_toan_repository.dart';

class HinhThucThanhToanProvider {
  HinhThucThanhToanRepository? repository = GetIt.I.get<HinhThucThanhToanRepository>();

  HinhThucThanhToanProvider();

  ///
  /// Get all hinhThucThanhToans
  ///
  Future<void> all({
    required Function(List<HinhThucThanhToanModel> hinhThucThanhToans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => HinhThucThanhToanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert hinhThucThanhToan to database
  ///
  Future<void> add({
    required HinhThucThanhToanModel data,
    required Function(HinhThucThanhToanModel hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HinhThucThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update hinhThucThanhToan to database
  ///
  Future<void> update({
    required HinhThucThanhToanModel data,
    required Function(HinhThucThanhToanModel hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HinhThucThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete hinhThucThanhToan to database
  ///
  Future<void> delete({
    required String id,
    required HinhThucThanhToanModel data,
    required Function(HinhThucThanhToanModel hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HinhThucThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate hinhThucThanhToans "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<HinhThucThanhToanModel> hinhThucThanhToans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => HinhThucThanhToanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete hinhThucThanhToan to database
  ///
  Future<void> find({
    required String id,
    required Function(HinhThucThanhToanModel hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HinhThucThanhToanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
