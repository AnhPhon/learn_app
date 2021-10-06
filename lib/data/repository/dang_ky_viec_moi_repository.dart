import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DangKyViecMoiRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DangKyViecMoiRepository();

  ///
  /// Get all dang-ky-viec-mois
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dang-ky-viec-mois');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dang-ky-viec-moi to database
  ///
  Future<ApiResponse> add(DangKyViecMoiModel data) async {
    try {
      final response = await dioClient!.post('/dang-ky-viec-mois', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-viec-moi to database
  ///
  Future<ApiResponse> update(DangKyViecMoiModel data) async {
    try {
      final response = await dioClient!.put('/dang-ky-viec-mois', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dang-ky-viec-moi to database
  ///
  Future<ApiResponse> delete(String id, DangKyViecMoiModel data) async {
    try {
      final response =
          await dioClient!.delete('/dang-ky-viec-mois/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dang-ky-viec-mois "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dang-ky-viec-mois/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dang-ky-viec-mois/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dang-ky-viec-moi by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dang-ky-viec-mois/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
