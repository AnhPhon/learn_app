import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/danh_muc_san_pham_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhMucSanPhamRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhMucSanPhamRepository();

  ///
  /// Get all danh-muc-san-phams
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-muc-san-phams');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-muc-san-pham to database
  ///
  Future<ApiResponse> add(DanhMucSanPhamRequest data) async {
    try {
      final response = await dioClient!.post('/danh-muc-san-phams', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-muc-san-pham to database
  ///
  Future<ApiResponse> update(DanhMucSanPhamRequest data) async {
    try {
      final response = await dioClient!.put('/danh-muc-san-phams', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-muc-san-pham to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/danh-muc-san-phams/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-muc-san-phams "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-muc-san-phams/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-muc-san-phams/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-muc-san-pham by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-muc-san-phams/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
