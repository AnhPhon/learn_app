import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/bang_gia_don_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangGiaDonHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangGiaDonHangRepository();

  ///
  /// Get all bang-gia-don-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-gia-don-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-don-hang to database
  ///
  Future<ApiResponse> add(BangGiaDonHangModel data) async {
    try {
      final response = await dioClient!.post('/bang-gia-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-don-hang to database
  ///
  Future<ApiResponse> update(BangGiaDonHangModel data) async {
    try {
      final response = await dioClient!.put('/bang-gia-don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-don-hang to database
  ///
  Future<ApiResponse> delete(String id, BangGiaDonHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/bang-gia-don-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-gia-don-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-gia-don-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-gia-don-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-gia-don-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-gia-don-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
