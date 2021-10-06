import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/trang_thai_bao_gia_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrangThaiBaoGiaRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrangThaiBaoGiaRepository();

  ///
  /// Get all trang-thai-bao-gias
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trang-thai-bao-gias');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trang-thai-bao-gia to database
  ///
  Future<ApiResponse> add(TrangThaiBaoGiaModel data) async {
    try {
      final response = await dioClient!.post('/trang-thai-bao-gias', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-bao-gia to database
  ///
  Future<ApiResponse> update(TrangThaiBaoGiaModel data) async {
    try {
      final response = await dioClient!.put('/trang-thai-bao-gias', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-bao-gia to database
  ///
  Future<ApiResponse> delete(String id, TrangThaiBaoGiaModel data) async {
    try {
      final response =
          await dioClient!.delete('/trang-thai-bao-gias/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trang-thai-bao-gias "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trang-thai-bao-gias/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trang-thai-bao-gias/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trang-thai-bao-gia by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trang-thai-bao-gias/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
