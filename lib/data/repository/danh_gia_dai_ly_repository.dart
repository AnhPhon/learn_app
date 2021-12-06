import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/danh_gia_dai_ly_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhGiaDaiLyRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhGiaDaiLyRepository();

  ///
  /// Get all danh-gia-dai-lys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-gia-dai-lys');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-gia-dai-ly to database
  ///
  Future<ApiResponse> add(DanhGiaDaiLyRequest data) async {
    try {
      final response = await dioClient!.post('/danh-gia-dai-lys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-gia-dai-ly to database
  ///
  Future<ApiResponse> update(DanhGiaDaiLyRequest data) async {
    try {
      final response = await dioClient!.put('/danh-gia-dai-lys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-gia-dai-ly to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/danh-gia-dai-lys/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-gia-dai-lys "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-gia-dai-lys/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-gia-dai-lys/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-gia-dai-ly by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-gia-dai-lys/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
