import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/trang_thai_don_dich_vu_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrangThaiDonDichVuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrangThaiDonDichVuRepository();

  ///
  /// Get all trang-thai-don-dich-vus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trang-thai-don-dich-vus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trang-thai-don-dich-vu to database
  ///
  Future<ApiResponse> add(TrangThaiDonDichVuRequest data) async {
    try {
      final response = await dioClient!
          .post('/trang-thai-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-don-dich-vu to database
  ///
  Future<ApiResponse> update(TrangThaiDonDichVuRequest data) async {
    try {
      final response =
          await dioClient!.put('/trang-thai-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-don-dich-vu to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/trang-thai-don-dich-vus/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trang-thai-don-dich-vus "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trang-thai-don-dich-vus/paginate?page=$page&limit=$limit'
          .toString();

      // add condition filter
      if (filter != '') {
        uri =
            '/trang-thai-don-dich-vus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trang-thai-don-dich-vu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trang-thai-don-dich-vus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
