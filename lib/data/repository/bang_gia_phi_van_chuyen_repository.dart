import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/bang_gia_phi_van_chuyen_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangGiaPhiVanChuyenRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangGiaPhiVanChuyenRepository();

  ///
  /// Get all bang-gia-phi-van-chuyens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-gia-phi-van-chuyens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-phi-van-chuyen to database
  ///
  Future<ApiResponse> add(BangGiaPhiVanChuyenModel data) async {
    try {
      final response = await dioClient!.post('/bang-gia-phi-van-chuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-phi-van-chuyen to database
  ///
  Future<ApiResponse> update(BangGiaPhiVanChuyenModel data) async {
    try {
      final response = await dioClient!.put('/bang-gia-phi-van-chuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-phi-van-chuyen to database
  ///
  Future<ApiResponse> delete(String id, BangGiaPhiVanChuyenModel data) async {
    try {
      final response =
          await dioClient!.delete('/bang-gia-phi-van-chuyens/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-gia-phi-van-chuyens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-gia-phi-van-chuyens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-gia-phi-van-chuyens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-gia-phi-van-chuyen by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-gia-phi-van-chuyens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
