import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/yeu_cau_bao_hanh_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class YeuCauBaoHanhRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  YeuCauBaoHanhRepository();

  ///
  /// Get all yeu-cau-bao-hanhs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/yeu-cau-bao-hanhs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert yeu-cau-bao-hanh to database
  ///
  Future<ApiResponse> add(YeuCauBaoHanhRequest data) async {
    try {
      final response = await dioClient!.post('/yeu-cau-bao-hanhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update yeu-cau-bao-hanh to database
  ///
  Future<ApiResponse> update(YeuCauBaoHanhRequest data) async {
    try {
      final response = await dioClient!.put('/yeu-cau-bao-hanhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update yeu-cau-bao-hanh to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/yeu-cau-bao-hanhs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate yeu-cau-bao-hanhs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/yeu-cau-bao-hanhs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/yeu-cau-bao-hanhs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find yeu-cau-bao-hanh by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/yeu-cau-bao-hanhs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
