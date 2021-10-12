import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/dang_ky_bao_hiem_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DangKyBaoHiemRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DangKyBaoHiemRepository();

  ///
  /// Get all dang-ky-bao-hiems
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dang-ky-bao-hiems');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dang-ky-bao-hiem to database
  ///
  Future<ApiResponse> add(DangKyBaoHiemRequest data) async {
    try {
      final response = await dioClient!.post('/dang-ky-bao-hiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-bao-hiem to database
  ///
  Future<ApiResponse> update(DangKyBaoHiemRequest data) async {
    try {
      final response = await dioClient!.put('/dang-ky-bao-hiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-bao-hiem to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/dang-ky-bao-hiems/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dang-ky-bao-hiems "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dang-ky-bao-hiems/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dang-ky-bao-hiems/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dang-ky-bao-hiem by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dang-ky-bao-hiems/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
