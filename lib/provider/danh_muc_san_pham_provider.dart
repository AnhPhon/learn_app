import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_muc_san_pham_request.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_muc_san_pham_repository.dart';

class DanhMucSanPhamProvider {
  DanhMucSanPhamRepository? repository =
      GetIt.I.get<DanhMucSanPhamRepository>();

  DanhMucSanPhamProvider();

  ///
  /// Get all danhMucSanPhams
  ///
  Future<void> all({
    required Function(List<DanhMucSanPhamResponse> danhMucSanPhams) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map(
              (e) => DanhMucSanPhamResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhMucSanPham to database
  ///
  Future<void> add({
    required DanhMucSanPhamRequest data,
    required Function(DanhMucSanPhamRequest danhMucSanPham) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DanhMucSanPhamRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhMucSanPham to database
  ///
  Future<void> update({
    required DanhMucSanPhamRequest data,
    required Function(DanhMucSanPhamRequest danhMucSanPham) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DanhMucSanPhamRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhMucSanPham to database
  ///
  Future<void> delete({
    required String id,
    required Function(DanhMucSanPhamRequest danhMucSanPham) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DanhMucSanPhamRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhMucSanPhams "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhMucSanPhamResponse> danhMucSanPhams) onSuccess,
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
          .map(
              (e) => DanhMucSanPhamResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhMucSanPham to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhMucSanPhamResponse danhMucSanPham) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DanhMucSanPhamResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
