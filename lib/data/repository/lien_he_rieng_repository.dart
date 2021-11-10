import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/lien_he_rieng_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LienHeRiengRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LienHeRiengRepository();

  ///
  /// Get all lien-he-riengs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/lien-he-riengs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert lien-he-rieng to database
  ///
  Future<ApiResponse> add(LienHeRiengRequest data) async {
    try {
      final response = await dioClient!.post('/lien-he-riengs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lien-he-rieng to database
  ///
  Future<ApiResponse> update(LienHeRiengRequest data) async {
    try {
      final response = await dioClient!.put('/lien-he-riengs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lien-he-rieng to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/lien-he-riengs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate lien-he-riengs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/lien-he-riengs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/lien-he-riengs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find lien-he-rieng by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/lien-he-riengs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
