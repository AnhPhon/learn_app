import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/trang_thai_thanh_toan_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrangThaiThanhToanRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrangThaiThanhToanRepository();

  ///
  /// Get all trang-thai-thanh-toans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trang-thai-thanh-toans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trang-thai-thanh-toan to database
  ///
  Future<ApiResponse> add(TrangThaiThanhToanRequest data) async {
    try {
      final response = await dioClient!.post('/trang-thai-thanh-toans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-thanh-toan to database
  ///
  Future<ApiResponse> update(TrangThaiThanhToanRequest data) async {
    try {
      final response = await dioClient!.put('/trang-thai-thanh-toans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-thanh-toan to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/trang-thai-thanh-toans/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trang-thai-thanh-toans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trang-thai-thanh-toans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trang-thai-thanh-toans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trang-thai-thanh-toan by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trang-thai-thanh-toans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
