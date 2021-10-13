import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/bang_gia_loc_ho_so_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangGiaLocHoSoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangGiaLocHoSoRepository();

  ///
  /// Get all bang-gia-loc-ho-sos
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-gia-loc-ho-sos');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-loc-ho-so to database
  ///
  Future<ApiResponse> add(BangGiaLocHoSoRequest data) async {
    try {
      final response = await dioClient!.post('/bang-gia-loc-ho-sos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-loc-ho-so to database
  ///
  Future<ApiResponse> update(BangGiaLocHoSoRequest data) async {
    try {
      final response = await dioClient!.put('/bang-gia-loc-ho-sos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-loc-ho-so to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/bang-gia-loc-ho-sos/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-gia-loc-ho-sos "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-gia-loc-ho-sos/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-gia-loc-ho-sos/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-gia-loc-ho-so by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-gia-loc-ho-sos/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
