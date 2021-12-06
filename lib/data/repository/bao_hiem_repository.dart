import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/bao_hiem_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BaoHiemRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BaoHiemRepository();

  ///
  /// Get all bao-hiems
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bao-hiems');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bao-hiem to database
  ///
  Future<ApiResponse> add(BaoHiemRequest data) async {
    try {
      final response = await dioClient!.post('/bao-hiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bao-hiem to database
  ///
  Future<ApiResponse> update(BaoHiemRequest data) async {
    try {
      final response = await dioClient!.put('/bao-hiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bao-hiem to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/bao-hiems/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bao-hiems "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bao-hiems/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bao-hiems/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bao-hiem by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bao-hiems/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
