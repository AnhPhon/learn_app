import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/danh_sach_bao_gia_don_dich_vu_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhSachBaoGiaDonDichVuRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhSachBaoGiaDonDichVuRepository();

  ///
  /// Get all danh-sach-bao-gia-don-dich-vus
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-sach-bao-gia-don-dich-vus');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-sach-bao-gia-don-dich-vu to database
  ///
  Future<ApiResponse> add(DanhSachBaoGiaDonDichVuModel data) async {
    try {
      final response = await dioClient!.post('/danh-sach-bao-gia-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-bao-gia-don-dich-vu to database
  ///
  Future<ApiResponse> update(DanhSachBaoGiaDonDichVuModel data) async {
    try {
      final response = await dioClient!.put('/danh-sach-bao-gia-don-dich-vus', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-bao-gia-don-dich-vu to database
  ///
  Future<ApiResponse> delete(String id, DanhSachBaoGiaDonDichVuModel data) async {
    try {
      final response =
          await dioClient!.delete('/danh-sach-bao-gia-don-dich-vus/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-sach-bao-gia-don-dich-vus "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-sach-bao-gia-don-dich-vus/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-sach-bao-gia-don-dich-vus/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-sach-bao-gia-don-dich-vu by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-sach-bao-gia-don-dich-vus/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
