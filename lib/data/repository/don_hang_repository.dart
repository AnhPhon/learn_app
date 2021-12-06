import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DonHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DonHangRepository();

  ///
  /// Get all don-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/don-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert don-hang to database
  ///
  Future<ApiResponse> add(DonHangRequest data) async {
    try {
      final response = await dioClient!.post('/don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-hang to database
  ///
  Future<ApiResponse> update(DonHangRequest data) async {
    try {
      final response = await dioClient!.put('/don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-hang to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/don-hangs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate don-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/don-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate donHangDaiLy "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> donHangDaiLy(int page, int limit, String filter) async {
    try {
      String uri = '/don-hangs/don-hang-dai-ly?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-hangs/don-hang-dai-ly?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate doanhThuDaiLy, filter 
  ///
  Future<ApiResponse> doanhThuDaiLy(String filter) async {
    try {
     
      final String uri = '/don-hangs/doanh-thu-dai-lys?$filter'.toString();

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find don-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/don-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
