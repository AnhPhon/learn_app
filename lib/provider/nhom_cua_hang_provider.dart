import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/nhom_cua_hang_request.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/nhom_cua_hang_repository.dart';

class NhomCuaHangProvider {
  NhomCuaHangRepository? repository = GetIt.I.get<NhomCuaHangRepository>();

  NhomCuaHangProvider();

  ///
  /// Get all nhomCuaHangs
  ///
  Future<void> all({
    required Function(List<NhomCuaHangResponse> nhomCuaHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => NhomCuaHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert nhomCuaHang to database
  ///
  Future<void> add({
    required NhomCuaHangRequest data,
    required Function(NhomCuaHangRequest nhomCuaHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NhomCuaHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update nhomCuaHang to database
  ///
  Future<void> update({
    required NhomCuaHangRequest data,
    required Function(NhomCuaHangRequest nhomCuaHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NhomCuaHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete nhomCuaHang to database
  ///
  Future<void> delete({
    required String id,
    required Function(NhomCuaHangRequest nhomCuaHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NhomCuaHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate nhomCuaHangs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<NhomCuaHangResponse> nhomCuaHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => NhomCuaHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete nhomCuaHang to database
  ///
  Future<void> find({
    required String id,
    required Function(NhomCuaHangResponse nhomCuaHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NhomCuaHangResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
