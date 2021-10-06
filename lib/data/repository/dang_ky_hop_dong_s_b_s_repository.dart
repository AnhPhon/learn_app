import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/dang_ky_hop_dong_s_b_s_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DangKyHopDongSBSRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DangKyHopDongSBSRepository();

  ///
  /// Get all dang-ky-hop-dong-s-b-ss
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dang-ky-hop-dong-s-b-ss');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dang-ky-hop-dong-s-b-s to database
  ///
  Future<ApiResponse> add(DangKyHopDongSBSModel data) async {
    try {
      final response = await dioClient!.post('/dang-ky-hop-dong-s-b-ss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-hop-dong-s-b-s to database
  ///
  Future<ApiResponse> update(DangKyHopDongSBSModel data) async {
    try {
      final response = await dioClient!.put('/dang-ky-hop-dong-s-b-ss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-hop-dong-s-b-s to database
  ///
  Future<ApiResponse> delete(String id, DangKyHopDongSBSModel data) async {
    try {
      final response =
          await dioClient!.delete('/dang-ky-hop-dong-s-b-ss/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dang-ky-hop-dong-s-b-ss "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dang-ky-hop-dong-s-b-ss/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dang-ky-hop-dong-s-b-ss/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dang-ky-hop-dong-s-b-s by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dang-ky-hop-dong-s-b-ss/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
