import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/hinh_thuc_thanh_toan_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class HinhThucThanhToanRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  HinhThucThanhToanRepository();

  ///
  /// Get all hinh-thuc-thanh-toans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/hinh-thuc-thanh-toans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert hinh-thuc-thanh-toan to database
  ///
  Future<ApiResponse> add(HinhThucThanhToanModel data) async {
    try {
      final response = await dioClient!.post('/hinh-thuc-thanh-toans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hinh-thuc-thanh-toan to database
  ///
  Future<ApiResponse> update(HinhThucThanhToanModel data) async {
    try {
      final response = await dioClient!.put('/hinh-thuc-thanh-toans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hinh-thuc-thanh-toan to database
  ///
  Future<ApiResponse> delete(String id, HinhThucThanhToanModel data) async {
    try {
      final response =
          await dioClient!.delete('/hinh-thuc-thanh-toans/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate hinh-thuc-thanh-toans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/hinh-thuc-thanh-toans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/hinh-thuc-thanh-toans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find hinh-thuc-thanh-toan by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/hinh-thuc-thanh-toans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
