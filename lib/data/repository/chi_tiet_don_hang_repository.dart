import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/chi_tiet_don_hang_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChiTietDonHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChiTietDonHangRepository();

  ///
  /// Get all chi-tiet-don-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chi-tiet-don-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert chi-tiet-don-hang to database
  ///
  Future<ApiResponse> add(ChiTietDonHangRequest data) async {
    try {
      final response = await dioClient!.post('/chi-tiet-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chi-tiet-don-hang to database
  ///
  Future<ApiResponse> update(ChiTietDonHangRequest data) async {
    try {
      final response = await dioClient!.put('/chi-tiet-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chi-tiet-don-hang to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/chi-tiet-don-hangs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chi-tiet-don-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chi-tiet-don-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chi-tiet-don-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chiTietDonHangDaiLy "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> chiTietDonHangDaiLy(int page, int limit, String filter) async {
    try {
      String uri = '/chi-tiet-don-hangs/chi-tiet-don-hang-dai-ly?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chi-tiet-don-hangs/chi-tiet-don-hang-dai-ly?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find chi-tiet-don-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/chi-tiet-don-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
