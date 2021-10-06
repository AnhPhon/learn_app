import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/quan_huyen_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class QuanHuyenRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  QuanHuyenRepository();

  ///
  /// Get all quan-huyens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/quan-huyens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert quan-huyen to database
  ///
  Future<ApiResponse> add(QuanHuyenModel data) async {
    try {
      final response = await dioClient!.post('/quan-huyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update quan-huyen to database
  ///
  Future<ApiResponse> update(QuanHuyenModel data) async {
    try {
      final response = await dioClient!.put('/quan-huyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update quan-huyen to database
  ///
  Future<ApiResponse> delete(String id, QuanHuyenModel data) async {
    try {
      final response =
          await dioClient!.delete('/quan-huyens/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate quan-huyens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/quan-huyens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/quan-huyens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find quan-huyen by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/quan-huyens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
