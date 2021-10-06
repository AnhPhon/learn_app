import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/dang_ky_thue_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DangKyThueRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DangKyThueRepository();

  ///
  /// Get all dang-ky-thues
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dang-ky-thues');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dang-ky-thue to database
  ///
  Future<ApiResponse> add(DangKyThueModel data) async {
    try {
      final response = await dioClient!.post('/dang-ky-thues', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-thue to database
  ///
  Future<ApiResponse> update(DangKyThueModel data) async {
    try {
      final response = await dioClient!.put('/dang-ky-thues', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-thue to database
  ///
  Future<ApiResponse> delete(String id, DangKyThueModel data) async {
    try {
      final response =
          await dioClient!.delete('/dang-ky-thues/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dang-ky-thues "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dang-ky-thues/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dang-ky-thues/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dang-ky-thue by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dang-ky-thues/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
