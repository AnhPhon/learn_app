import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/loai_van_chuyen_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiVanChuyenRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiVanChuyenRepository();

  ///
  /// Get all loai-van-chuyens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/loai-van-chuyens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-van-chuyen to database
  ///
  Future<ApiResponse> add(LoaiVanChuyenRequest data) async {
    try {
      final response = await dioClient!.post('/loai-van-chuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-van-chuyen to database
  ///
  Future<ApiResponse> update(LoaiVanChuyenRequest data) async {
    try {
      final response = await dioClient!.put('/loai-van-chuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-van-chuyen to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/loai-van-chuyens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate loai-van-chuyens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/loai-van-chuyens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/loai-van-chuyens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find loai-van-chuyen by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/loai-van-chuyens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
