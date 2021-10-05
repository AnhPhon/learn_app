import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/nhom_dich_vu_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NhomDichVuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NhomDichVuRepository();

  ///
  /// Get all nhom-dich-vus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/nhom-dich-vus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert nhom-dich-vu to database
  ///
  Future<ApiResponse> add(NhomDichVuModel data) async {
    try {
      final response = await dioClient!.post('/nhom-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhom-dich-vu to database
  ///
  Future<ApiResponse> update(NhomDichVuModel data) async {
    try {
      final response = await dioClient!.put('/nhom-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhom-dich-vu to database
  ///
  Future<ApiResponse> delete(String id, NhomDichVuModel data) async {
    try {
      final response =
          await dioClient!.delete('/nhom-dich-vus/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate nhom-dich-vus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/nhom-dich-vus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/nhom-dich-vus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find nhom-dich-vu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/nhom-dich-vus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
