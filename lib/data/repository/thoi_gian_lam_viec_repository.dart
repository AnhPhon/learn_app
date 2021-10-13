import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thoi_gian_lam_viec_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThoiGianLamViecRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThoiGianLamViecRepository();

  ///
  /// Get all thoi-gian-lam-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thoi-gian-lam-viecs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thoi-gian-lam-viec to database
  ///
  Future<ApiResponse> add(ThoiGianLamViecRequest data) async {
    try {
      final response = await dioClient!.post('/thoi-gian-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thoi-gian-lam-viec to database
  ///
  Future<ApiResponse> update(ThoiGianLamViecRequest data) async {
    try {
      final response = await dioClient!.put('/thoi-gian-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thoi-gian-lam-viec to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/thoi-gian-lam-viecs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thoi-gian-lam-viecs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thoi-gian-lam-viecs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thoi-gian-lam-viecs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thoi-gian-lam-viec by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thoi-gian-lam-viecs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
