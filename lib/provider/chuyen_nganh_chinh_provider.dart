import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chuyen_nganh_chinh_request.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/chuyen_nganh_chinh_repository.dart';

class ChuyenNganhChinhProvider {
  ChuyenNganhChinhRepository? repository =
      GetIt.I.get<ChuyenNganhChinhRepository>();

  ChuyenNganhChinhProvider();

  ///
  /// Get all chuyenNganhChinhs
  ///
  Future<void> all({
    required Function(List<ChuyenNganhChinhResponse> chuyenNganhChinhs)
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
              ChuyenNganhChinhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert chuyenNganhChinh to database
  ///
  Future<void> add({
    required ChuyenNganhChinhRequest data,
    required Function(ChuyenNganhChinhRequest chuyenNganhChinh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ChuyenNganhChinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update chuyenNganhChinh to database
  ///
  Future<void> update({
    required ChuyenNganhChinhRequest data,
    required Function(ChuyenNganhChinhRequest chuyenNganhChinh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ChuyenNganhChinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chuyenNganhChinh to database
  ///
  Future<void> delete({
    required String id,
    required Function(ChuyenNganhChinhRequest chuyenNganhChinh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ChuyenNganhChinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate chuyenNganhChinhs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ChuyenNganhChinhResponse> chuyenNganhChinhs)
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
              ChuyenNganhChinhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chuyenNganhChinh to database
  ///
  Future<void> find({
    required String id,
    required Function(ChuyenNganhChinhResponse chuyenNganhChinh) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          ChuyenNganhChinhResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
