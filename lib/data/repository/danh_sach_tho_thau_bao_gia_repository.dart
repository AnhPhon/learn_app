import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/danh_sach_tho_thau_bao_gia_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DanhSachThoThauBaoGiaRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DanhSachThoThauBaoGiaRepository();

  ///
  /// Get all danh-sach-tho-thau-bao-gias
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/danh-sach-tho-thau-bao-gias');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert danh-sach-tho-thau-bao-gia to database
  ///
  Future<ApiResponse> add(DanhSachThoThauBaoGiaModel data) async {
    try {
      final response = await dioClient!.post('/danh-sach-tho-thau-bao-gias', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-tho-thau-bao-gia to database
  ///
  Future<ApiResponse> update(DanhSachThoThauBaoGiaModel data) async {
    try {
      final response = await dioClient!.put('/danh-sach-tho-thau-bao-gias', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update danh-sach-tho-thau-bao-gia to database
  ///
  Future<ApiResponse> delete(String id, DanhSachThoThauBaoGiaModel data) async {
    try {
      final response =
          await dioClient!.delete('/danh-sach-tho-thau-bao-gias/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate danh-sach-tho-thau-bao-gias "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/danh-sach-tho-thau-bao-gias/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/danh-sach-tho-thau-bao-gias/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find danh-sach-tho-thau-bao-gia by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/danh-sach-tho-thau-bao-gias/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
