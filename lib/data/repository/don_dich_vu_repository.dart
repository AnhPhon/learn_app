import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DonDichVuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DonDichVuRepository();

  ///
  /// Get all don-dich-vus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/don-dich-vus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert don-dich-vu to database
  ///
  Future<ApiResponse> add(DonDichVuRequest data) async {
    try {
      final response = await dioClient!.post('/don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-dich-vu to database
  ///
  Future<ApiResponse> update(DonDichVuRequest data) async {
    try {
      final response = await dioClient!.put('/don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-dich-vu to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/don-dich-vus/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate don-dich-vus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/don-dich-vus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-dich-vus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find don-dich-vu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/don-dich-vus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
