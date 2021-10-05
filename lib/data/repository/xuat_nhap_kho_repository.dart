import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/xuat_nhap_kho_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class XuatNhapKhoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  XuatNhapKhoRepository();

  ///
  /// Get all xuat-nhap-khos
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/xuat-nhap-khos');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert xuat-nhap-kho to database
  ///
  Future<ApiResponse> add(XuatNhapKhoModel data) async {
    try {
      final response = await dioClient!.post('/xuat-nhap-khos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update xuat-nhap-kho to database
  ///
  Future<ApiResponse> update(XuatNhapKhoModel data) async {
    try {
      final response = await dioClient!.put('/xuat-nhap-khos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update xuat-nhap-kho to database
  ///
  Future<ApiResponse> delete(String id, XuatNhapKhoModel data) async {
    try {
      final response =
          await dioClient!.delete('/xuat-nhap-khos/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate xuat-nhap-khos "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/xuat-nhap-khos/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/xuat-nhap-khos/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find xuat-nhap-kho by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/xuat-nhap-khos/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
