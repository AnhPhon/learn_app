import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/ngoai_ngu_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NgoaiNguRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NgoaiNguRepository();

  ///
  /// Get all ngoai-ngus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/ngoai-ngus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert ngoai-ngu to database
  ///
  Future<ApiResponse> add(NgoaiNguModel data) async {
    try {
      final response = await dioClient!.post('/ngoai-ngus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update ngoai-ngu to database
  ///
  Future<ApiResponse> update(NgoaiNguModel data) async {
    try {
      final response = await dioClient!.put('/ngoai-ngus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update ngoai-ngu to database
  ///
  Future<ApiResponse> delete(String id, NgoaiNguModel data) async {
    try {
      final response =
          await dioClient!.delete('/ngoai-ngus/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate ngoai-ngus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/ngoai-ngus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/ngoai-ngus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find ngoai-ngu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/ngoai-ngus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
