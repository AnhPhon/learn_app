import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/vat_tu_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class VatTuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  VatTuRepository();

  ///
  /// Get all vat-tus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/vat-tus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert vat-tu to database
  ///
  Future<ApiResponse> add(VatTuModel data) async {
    try {
      final response = await dioClient!.post('/vat-tus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update vat-tu to database
  ///
  Future<ApiResponse> update(VatTuModel data) async {
    try {
      final response = await dioClient!.put('/vat-tus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update vat-tu to database
  ///
  Future<ApiResponse> delete(String id, VatTuModel data) async {
    try {
      final response =
          await dioClient!.delete('/vat-tus/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate vat-tus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/vat-tus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/vat-tus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find vat-tu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/vat-tus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
