import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/danh_sach_xem_tuyen_dung_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhSachXemTuyenDungRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhSachXemTuyenDungRepository();

  ///
  /// Get all danh-sach-xem-tuyen-dungs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-sach-xem-tuyen-dungs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-sach-xem-tuyen-dung to database
  ///
  Future<ApiResponse> add(DanhSachXemTuyenDungRequest data) async {
    try {
      final response = await dioClient!
          .post('/danh-sach-xem-tuyen-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-xem-tuyen-dung to database
  ///
  Future<ApiResponse> update(DanhSachXemTuyenDungRequest data) async {
    try {
      final response = await dioClient!
          .put('/danh-sach-xem-tuyen-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-xem-tuyen-dung to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/danh-sach-xem-tuyen-dungs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-sach-xem-tuyen-dungs "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-sach-xem-tuyen-dungs/paginate?page=$page&limit=$limit'
          .toString();

      // add condition filter
      if (filter != '') {
        uri =
            '/danh-sach-xem-tuyen-dungs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-sach-xem-tuyen-dung by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-sach-xem-tuyen-dungs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
