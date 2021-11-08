import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thong_tin_thue_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongTinThueRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongTinThueRepository();

  ///
  /// Get all thong-tin-thues
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thong-tin-thues');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-tin-thue to database
  ///
  Future<ApiResponse> add(ThongTinThueRequest data) async {
    try {
      final response = await dioClient!.post('/thong-tin-thues', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-thue to database
  ///
  Future<ApiResponse> update(ThongTinThueRequest data) async {
    try {
      final response = await dioClient!.put('/thong-tin-thues', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-thue to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/thong-tin-thues/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-tin-thues "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-tin-thues/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-tin-thues/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-tin-thue by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-tin-thues/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
