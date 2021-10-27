import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/dia_diem_dang_ky_lam_viec_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DiaDiemDangKyLamViecRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DiaDiemDangKyLamViecRepository();

  ///
  /// Get all dia-diem-dang-ky-lam-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dia-diem-dang-ky-lam-viecs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dia-diem-dang-ky-lam-viec to database
  ///
  Future<ApiResponse> add(DiaDiemDangKyLamViecRequest data) async {
    try {
      final response = await dioClient!.post('/dia-diem-dang-ky-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dia-diem-dang-ky-lam-viec to database
  ///
  Future<ApiResponse> update(DiaDiemDangKyLamViecRequest data) async {
    try {
      final response = await dioClient!.put('/dia-diem-dang-ky-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dia-diem-dang-ky-lam-viec to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/dia-diem-dang-ky-lam-viecs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dia-diem-dang-ky-lam-viecs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dia-diem-dang-ky-lam-viecs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dia-diem-dang-ky-lam-viecs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dia-diem-dang-ky-lam-viec by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dia-diem-dang-ky-lam-viecs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
