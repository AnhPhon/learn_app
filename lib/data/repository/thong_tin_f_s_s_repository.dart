import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thong_tin_f_s_s_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongTinFSSRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongTinFSSRepository();

  ///
  /// Get all thong-tin-f-s-ss
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thong-tin-f-s-ss');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-tin-f-s-s to database
  ///
  Future<ApiResponse> add(ThongTinFSSRequest data) async {
    try {
      final response = await dioClient!.post('/thong-tin-f-s-ss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-f-s-s to database
  ///
  Future<ApiResponse> update(ThongTinFSSRequest data) async {
    try {
      final response = await dioClient!.put('/thong-tin-f-s-ss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-f-s-s to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/thong-tin-f-s-ss/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-tin-f-s-ss "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-tin-f-s-ss/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-tin-f-s-ss/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-tin-f-s-s by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-tin-f-s-ss/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
