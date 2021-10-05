import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/trang_thai_don_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrangThaiDonHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrangThaiDonHangRepository();

  ///
  /// Get all trang-thai-don-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trang-thai-don-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trang-thai-don-hang to database
  ///
  Future<ApiResponse> add(TrangThaiDonHangModel data) async {
    try {
      final response = await dioClient!.post('/trang-thai-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-don-hang to database
  ///
  Future<ApiResponse> update(TrangThaiDonHangModel data) async {
    try {
      final response = await dioClient!.put('/trang-thai-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-don-hang to database
  ///
  Future<ApiResponse> delete(String id, TrangThaiDonHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/trang-thai-don-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trang-thai-don-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trang-thai-don-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trang-thai-don-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trang-thai-don-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trang-thai-don-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
