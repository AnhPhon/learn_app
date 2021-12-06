

import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/chi_tiet_gia_tham_khao_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChiTietGiaThamKhaoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChiTietGiaThamKhaoRepository();

  ///
  /// Get all chi-tiet-gia-tham-khaos
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chi-tiet-gia-tham-khaos');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-loc-ho-so to database
  ///
  Future<ApiResponse> add(ChiTietGiaThamKhaoRequest data) async {
    try {
      final response = await dioClient!.post('/chi-tiet-gia-tham-khaos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-loc-ho-so to database
  ///
  Future<ApiResponse> update(ChiTietGiaThamKhaoRequest data) async {
    try {
      final response = await dioClient!.put('/chi-tiet-gia-tham-khaos', data: data.toJson());
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
          await dioClient!.delete('/chi-tiet-gia-tham-khaos/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chi-tiet-gia-tham-khaos "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chi-tiet-gia-tham-khaos/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chi-tiet-gia-tham-khaos/paginate?page=$page&limit=$limit$filter';
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
      final String uri = '/chi-tiet-gia-tham-khaos/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
