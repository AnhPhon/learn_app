import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thong_tin_dang_ky_hop_dong_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongTinDangKyHopDongRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongTinDangKyHopDongRepository();

  ///
  /// Get all thong-tin-dang-ky-hop-dongs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('{{url}}/v1/vi-tiens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-tin-dang-ky-hop-dong to database
  ///
  Future<ApiResponse> add(ThongTinDangKyHopDongRequest data) async {
    try {
      final response = await dioClient!.post('/thong-tin-dang-ky-hop-dongs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-dang-ky-hop-dong to database
  ///
  Future<ApiResponse> update(ThongTinDangKyHopDongRequest data) async {
    try {
      final response = await dioClient!.put('/thong-tin-dang-ky-hop-dongs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-dang-ky-hop-dong to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/thong-tin-dang-ky-hop-dongs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-tin-dang-ky-hop-dongs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-tin-dang-ky-hop-dongs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-tin-dang-ky-hop-dongs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-tin-dang-ky-hop-dong by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-tin-dang-ky-hop-dongs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
