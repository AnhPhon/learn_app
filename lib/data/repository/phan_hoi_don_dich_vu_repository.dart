import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class PhanHoiDonDichVuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  PhanHoiDonDichVuRepository();

  ///
  /// Get all phan-hoi-don-dich-vus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/phan-hoi-don-dich-vus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert phan-hoi-don-dich-vu to database
  ///
  Future<ApiResponse> add(PhanHoiDonDichVuRequest data) async {
    try {
      final response = await dioClient!.post('/phan-hoi-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phan-hoi-don-dich-vu to database
  ///
  Future<ApiResponse> update(PhanHoiDonDichVuRequest data) async {
    try {
      final response = await dioClient!.put('/phan-hoi-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phan-hoi-don-dich-vu to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/phan-hoi-don-dich-vus/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate phan-hoi-don-dich-vus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/phan-hoi-don-dich-vus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/phan-hoi-don-dich-vus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find phan-hoi-don-dich-vu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/phan-hoi-don-dich-vus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
