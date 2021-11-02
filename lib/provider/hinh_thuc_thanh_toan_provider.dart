import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/hinh_thuc_thanh_toan_request.dart';
import 'package:template/data/model/response/hinh_thuc_thanh_toan_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/hinh_thuc_thanh_toan_repository.dart';

class HinhThucThanhToanProvider {
  HinhThucThanhToanRepository? repository =
      GetIt.I.get<HinhThucThanhToanRepository>();

  HinhThucThanhToanProvider();

  ///
  /// Get all hinhThucThanhToans
  ///
  Future<void> all({
    required Function(List<HinhThucThanhToanResponse> hinhThucThanhToans)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) =>
              HinhThucThanhToanResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert hinhThucThanhToan to database
  ///
  Future<void> add({
    required HinhThucThanhToanRequest data,
    required Function(HinhThucThanhToanRequest hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          HinhThucThanhToanRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update hinhThucThanhToan to database
  ///
  Future<void> update({
    required HinhThucThanhToanRequest data,
    required Function(HinhThucThanhToanRequest hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          HinhThucThanhToanRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete hinhThucThanhToan to database
  ///
  Future<void> delete({
    required String id,
    required Function(HinhThucThanhToanRequest hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          HinhThucThanhToanRequest.fromJson(results as Map<String, dynamic>));
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
    required Function(List<HinhThucThanhToanResponse> hinhThucThanhToans)
        onSuccess,
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
              HinhThucThanhToanResponse.fromJson(e as Map<String, dynamic>))
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
    required Function(HinhThucThanhToanResponse hinhThucThanhToan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          HinhThucThanhToanResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
