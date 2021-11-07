import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/bang_gia_dang_tin_request.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChiTietCongViecRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChiTietCongViecRepository();

  ///
  /// Get all chi-tiet-cong-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chi-tiet-cong-viecs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-dang-tin to database
  ///
  Future<ApiResponse> add(ChiTietCongViecRequest data) async {
    try {
      final response = await dioClient!.post('/chi-tiet-cong-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-dang-tin to database
  ///
  Future<ApiResponse> update(ChiTietCongViecRequest data) async {
    try {
      final response = await dioClient!.put('/chi-tiet-cong-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-dang-tin to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/chi-tiet-cong-viecs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chi-tiet-cong-viecs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chi-tiet-cong-viecs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chi-tiet-cong-viecs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-gia-dang-tin by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/chi-tiet-cong-viecs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
