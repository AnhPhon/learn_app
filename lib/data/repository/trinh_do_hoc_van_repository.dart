import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/trinh_do_hoc_van_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrinhDoHocVanRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrinhDoHocVanRepository();

  ///
  /// Get all trinh-do-hoc-vans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trinh-do-hoc-vans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trinh-do-hoc-van to database
  ///
  Future<ApiResponse> add(TrinhDoHocVanRequest data) async {
    try {
      final response = await dioClient!.post('/trinh-do-hoc-vans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trinh-do-hoc-van to database
  ///
  Future<ApiResponse> update(TrinhDoHocVanRequest data) async {
    try {
      final response = await dioClient!.put('/trinh-do-hoc-vans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trinh-do-hoc-van to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/trinh-do-hoc-vans/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trinh-do-hoc-vans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trinh-do-hoc-vans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trinh-do-hoc-vans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trinh-do-hoc-van by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trinh-do-hoc-vans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
