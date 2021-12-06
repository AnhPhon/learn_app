import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/danh_muc_tin_tuc_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhMucTinTucRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhMucTinTucRepository();

  ///
  /// Get all danh-muc-tin-tucs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-muc-tin-tucs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-muc-tin-tuc to database
  ///
  Future<ApiResponse> add(DanhMucTinTucRequest data) async {
    try {
      final response = await dioClient!.post('/danh-muc-tin-tucs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-muc-tin-tuc to database
  ///
  Future<ApiResponse> update(DanhMucTinTucRequest data) async {
    try {
      final response = await dioClient!.put('/danh-muc-tin-tucs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-muc-tin-tuc to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/danh-muc-tin-tucs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-muc-tin-tucs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-muc-tin-tucs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-muc-tin-tucs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-muc-tin-tuc by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-muc-tin-tucs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
