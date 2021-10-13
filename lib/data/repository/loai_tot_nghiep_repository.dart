import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/loai_tot_nghiep_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiTotNghiepRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiTotNghiepRepository();

  ///
  /// Get all loai-tot-nghieps
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/loai-tot-nghieps');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-tot-nghiep to database
  ///
  Future<ApiResponse> add(LoaiTotNghiepRequest data) async {
    try {
      final response = await dioClient!.post('/loai-tot-nghieps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-tot-nghiep to database
  ///
  Future<ApiResponse> update(LoaiTotNghiepRequest data) async {
    try {
      final response = await dioClient!.put('/loai-tot-nghieps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-tot-nghiep to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/loai-tot-nghieps/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate loai-tot-nghieps "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/loai-tot-nghieps/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/loai-tot-nghieps/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find loai-tot-nghiep by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/loai-tot-nghieps/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
