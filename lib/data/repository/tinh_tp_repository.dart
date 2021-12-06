import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/tinh_tp_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TinhTpRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TinhTpRepository();

  ///
  /// Get all tinh-tps
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/tinh-tps');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert tinh-tp to database
  ///
  Future<ApiResponse> add(TinhTpRequest data) async {
    try {
      final response = await dioClient!.post('/tinh-tps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tinh-tp to database
  ///
  Future<ApiResponse> update(TinhTpRequest data) async {
    try {
      final response = await dioClient!.put('/tinh-tps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tinh-tp to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/tinh-tps/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate tinh-tps "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/tinh-tps/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/tinh-tps/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find tinh-tp by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/tinh-tps/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
