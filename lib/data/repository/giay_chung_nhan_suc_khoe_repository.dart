import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/giay_chung_nhan_suc_khoe_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class GiayChungNhanSucKhoeRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  GiayChungNhanSucKhoeRepository();

  ///
  /// Get all giay-chung-nhan-suc-khoes
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/giay-chung-nhan-suc-khoes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert giay-chung-nhan-suc-khoe to database
  ///
  Future<ApiResponse> add(GiayChungNhanSucKhoeRequest data) async {
    try {
      final response = await dioClient!.post('/giay-chung-nhan-suc-khoes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update giay-chung-nhan-suc-khoe to database
  ///
  Future<ApiResponse> update(GiayChungNhanSucKhoeRequest data) async {
    try {
      final response = await dioClient!.put('/giay-chung-nhan-suc-khoes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update giay-chung-nhan-suc-khoe to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/giay-chung-nhan-suc-khoes/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate giay-chung-nhan-suc-khoes "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/giay-chung-nhan-suc-khoes/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/giay-chung-nhan-suc-khoes/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find giay-chung-nhan-suc-khoe by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/giay-chung-nhan-suc-khoes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
