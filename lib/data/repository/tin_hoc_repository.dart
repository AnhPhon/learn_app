import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/tin_hoc_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TinHocRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TinHocRepository();

  ///
  /// Get all tin-hocs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/tin-hocs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert tin-hoc to database
  ///
  Future<ApiResponse> add(TinHocModel data) async {
    try {
      final response = await dioClient!.post('/tin-hocs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tin-hoc to database
  ///
  Future<ApiResponse> update(TinHocModel data) async {
    try {
      final response = await dioClient!.put('/tin-hocs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tin-hoc to database
  ///
  Future<ApiResponse> delete(String id, TinHocModel data) async {
    try {
      final response =
          await dioClient!.delete('/tin-hocs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate tin-hocs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/tin-hocs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/tin-hocs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find tin-hoc by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/tin-hocs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
