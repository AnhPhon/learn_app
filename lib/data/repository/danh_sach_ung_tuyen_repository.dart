import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/danh_sach_ung_tuyen_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhSachUngTuyenRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhSachUngTuyenRepository();

  ///
  /// Get all danh-sach-ung-tuyens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-sach-ung-tuyens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-sach-ung-tuyen to database
  ///
  Future<ApiResponse> add(DanhSachUngTuyenModel data) async {
    try {
      final response = await dioClient!.post('/danh-sach-ung-tuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-ung-tuyen to database
  ///
  Future<ApiResponse> update(DanhSachUngTuyenModel data) async {
    try {
      final response = await dioClient!.put('/danh-sach-ung-tuyens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-ung-tuyen to database
  ///
  Future<ApiResponse> delete(String id, DanhSachUngTuyenModel data) async {
    try {
      final response =
          await dioClient!.delete('/danh-sach-ung-tuyens/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-sach-ung-tuyens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-sach-ung-tuyens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-sach-ung-tuyens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-sach-ung-tuyen by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-sach-ung-tuyens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
