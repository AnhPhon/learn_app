import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/loai_cong_viec_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiCongViecRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiCongViecRepository();

  ///
  /// Get all loai-cong-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/loai-cong-viecs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-cong-viec to database
  ///
  Future<ApiResponse> add(LoaiCongViecModel data) async {
    try {
      final response = await dioClient!.post('/loai-cong-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-cong-viec to database
  ///
  Future<ApiResponse> update(LoaiCongViecModel data) async {
    try {
      final response = await dioClient!.put('/loai-cong-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-cong-viec to database
  ///
  Future<ApiResponse> delete(String id, LoaiCongViecModel data) async {
    try {
      final response =
          await dioClient!.delete('/loai-cong-viecs/$id', data: data.toJson());
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
      String uri = '/loai-cong-viecs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/loai-cong-viecs/paginate?page=$page&limit=$limit$filter';
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
      final String uri = '/loai-cong-viecs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
