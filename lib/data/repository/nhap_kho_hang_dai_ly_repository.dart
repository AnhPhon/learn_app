import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/nhap_kho_hang_dai_ly_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NhapKhoHangDaiLyRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NhapKhoHangDaiLyRepository();

  ///
  /// Get all nhap-kho-hang-dai-lys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/nhap-kho-hang-dai-lys');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert nhap-kho-hang-dai-ly to database
  ///
  Future<ApiResponse> add(NhapKhoHangDaiLyRequest data) async {
    try {
      final response = await dioClient!.post('/nhap-kho-hang-dai-lys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhap-kho-hang-dai-ly to database
  ///
  Future<ApiResponse> update(NhapKhoHangDaiLyRequest data) async {
    try {
      final response = await dioClient!.put('/nhap-kho-hang-dai-lys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhap-kho-hang-dai-ly to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/nhap-kho-hang-dai-lys/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate nhap-kho-hang-dai-lys "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/nhap-kho-hang-dai-lys/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/nhap-kho-hang-dai-lys/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find nhap-kho-hang-dai-ly by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/nhap-kho-hang-dai-lys/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
