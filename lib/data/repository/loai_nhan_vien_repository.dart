import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/loai_nhan_vien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiNhanVienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiNhanVienRepository();

  ///
  /// Get all loai-nhan-viens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/loai-nhan-viens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-nhan-vien to database
  ///
  Future<ApiResponse> add(LoaiNhanVienRequest data) async {
    try {
      final response = await dioClient!.post('/loai-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-nhan-vien to database
  ///
  Future<ApiResponse> update(LoaiNhanVienRequest data) async {
    try {
      final response = await dioClient!.put('/loai-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-nhan-vien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/loai-nhan-viens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate loai-nhan-viens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/loai-nhan-viens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/loai-nhan-viens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find loai-nhan-vien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/loai-nhan-viens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
