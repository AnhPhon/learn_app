import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/chi_tiet_vat_tu_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChiTietVatTuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChiTietVatTuRepository();

  ///
  /// Get all chi-tiet-vat-tus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chi-tiet-vat-tus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert chi-tiet-vat-tu to database
  ///
  Future<ApiResponse> add(ChiTietVatTuRequest data) async {
    try {
      final response = await dioClient!.post('/chi-tiet-vat-tus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chi-tiet-vat-tu to database
  ///
  Future<ApiResponse> update(ChiTietVatTuRequest data) async {
    try {
      final response = await dioClient!.put('/chi-tiet-vat-tus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chi-tiet-vat-tu to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/chi-tiet-vat-tus/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chi-tiet-vat-tus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chi-tiet-vat-tus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chi-tiet-vat-tus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find chi-tiet-vat-tu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/chi-tiet-vat-tus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
