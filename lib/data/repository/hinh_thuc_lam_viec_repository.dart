import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/hinh_thuc_lam_viec_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class HinhThucLamViecRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  HinhThucLamViecRepository();

  ///
  /// Get all hinh-thuc-lam-viecs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/hinh-thuc-lam-viecs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert hinh-thuc-lam-viec to database
  ///
  Future<ApiResponse> add(HinhThucLamViecModel data) async {
    try {
      final response = await dioClient!.post('/hinh-thuc-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hinh-thuc-lam-viec to database
  ///
  Future<ApiResponse> update(HinhThucLamViecModel data) async {
    try {
      final response = await dioClient!.put('/hinh-thuc-lam-viecs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hinh-thuc-lam-viec to database
  ///
  Future<ApiResponse> delete(String id, HinhThucLamViecModel data) async {
    try {
      final response =
          await dioClient!.delete('/hinh-thuc-lam-viecs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate hinh-thuc-lam-viecs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/hinh-thuc-lam-viecs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/hinh-thuc-lam-viecs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find hinh-thuc-lam-viec by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/hinh-thuc-lam-viecs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
