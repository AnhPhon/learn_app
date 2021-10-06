import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/ke_khai_kinh_nghiem_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class KeKhaiKinhNghiemRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  KeKhaiKinhNghiemRepository();

  ///
  /// Get all ke-khai-kinh-nghiems
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/ke-khai-kinh-nghiems');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert ke-khai-kinh-nghiem to database
  ///
  Future<ApiResponse> add(KeKhaiKinhNghiemModel data) async {
    try {
      final response = await dioClient!.post('/ke-khai-kinh-nghiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update ke-khai-kinh-nghiem to database
  ///
  Future<ApiResponse> update(KeKhaiKinhNghiemModel data) async {
    try {
      final response = await dioClient!.put('/ke-khai-kinh-nghiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update ke-khai-kinh-nghiem to database
  ///
  Future<ApiResponse> delete(String id, KeKhaiKinhNghiemModel data) async {
    try {
      final response =
          await dioClient!.delete('/ke-khai-kinh-nghiems/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate ke-khai-kinh-nghiems "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/ke-khai-kinh-nghiems/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/ke-khai-kinh-nghiems/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find ke-khai-kinh-nghiem by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/ke-khai-kinh-nghiems/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
