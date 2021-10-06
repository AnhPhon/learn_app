import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/muc_luong_du_kien_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class MucLuongDuKienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  MucLuongDuKienRepository();

  ///
  /// Get all muc-luong-du-kiens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/muc-luong-du-kiens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert muc-luong-du-kien to database
  ///
  Future<ApiResponse> add(MucLuongDuKienModel data) async {
    try {
      final response = await dioClient!.post('/muc-luong-du-kiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update muc-luong-du-kien to database
  ///
  Future<ApiResponse> update(MucLuongDuKienModel data) async {
    try {
      final response = await dioClient!.put('/muc-luong-du-kiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update muc-luong-du-kien to database
  ///
  Future<ApiResponse> delete(String id, MucLuongDuKienModel data) async {
    try {
      final response =
          await dioClient!.delete('/muc-luong-du-kiens/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate muc-luong-du-kiens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/muc-luong-du-kiens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/muc-luong-du-kiens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find muc-luong-du-kien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/muc-luong-du-kiens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
