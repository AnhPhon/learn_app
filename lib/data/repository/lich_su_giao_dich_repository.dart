import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/lich_su_giao_dich_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LichSuGiaoDichRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LichSuGiaoDichRepository();

  ///
  /// Get all lich-su-giao-dichs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/lich-su-giao-dichs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert lich-su-giao-dich to database
  ///
  Future<ApiResponse> add(LichSuGiaoDichModel data) async {
    try {
      final response = await dioClient!.post('/lich-su-giao-dichs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lich-su-giao-dich to database
  ///
  Future<ApiResponse> update(LichSuGiaoDichModel data) async {
    try {
      final response = await dioClient!.put('/lich-su-giao-dichs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lich-su-giao-dich to database
  ///
  Future<ApiResponse> delete(String id, LichSuGiaoDichModel data) async {
    try {
      final response =
          await dioClient!.delete('/lich-su-giao-dichs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate lich-su-giao-dichs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/lich-su-giao-dichs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/lich-su-giao-dichs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find lich-su-giao-dich by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/lich-su-giao-dichs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
