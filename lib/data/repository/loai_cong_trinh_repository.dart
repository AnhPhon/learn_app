import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/loai_cong_trinh_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiCongTrinhRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiCongTrinhRepository();

  ///
  /// Get all loai-cong-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/cong-trinhs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-cong-viec to database
  ///
  Future<ApiResponse> add(LoaiCongTrinhRequest data) async {
    try {
      final response = await dioClient!.post('/cong-trinhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-cong-viec to database
  ///
  Future<ApiResponse> update(LoaiCongTrinhRequest data) async {
    try {
      final response = await dioClient!.put('/cong-trinhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-cong-viec to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/cong-trinhs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate loai-cong-viecs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/cong-trinhs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/cong-trinhs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find loai-cong-viec by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/cong-trinhs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
