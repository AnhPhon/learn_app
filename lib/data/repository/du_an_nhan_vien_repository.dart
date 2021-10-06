import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/du_an_nhan_vien_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DuAnNhanVienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DuAnNhanVienRepository();

  ///
  /// Get all du-an-nhan-viens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/du-an-nhan-viens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert du-an-nhan-vien to database
  ///
  Future<ApiResponse> add(DuAnNhanVienModel data) async {
    try {
      final response = await dioClient!.post('/du-an-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update du-an-nhan-vien to database
  ///
  Future<ApiResponse> update(DuAnNhanVienModel data) async {
    try {
      final response = await dioClient!.put('/du-an-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update du-an-nhan-vien to database
  ///
  Future<ApiResponse> delete(String id, DuAnNhanVienModel data) async {
    try {
      final response =
          await dioClient!.delete('/du-an-nhan-viens/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate du-an-nhan-viens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/du-an-nhan-viens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/du-an-nhan-viens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find du-an-nhan-vien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/du-an-nhan-viens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
