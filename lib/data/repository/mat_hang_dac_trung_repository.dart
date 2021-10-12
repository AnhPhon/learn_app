import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/mat_hang_dac_trung_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class MatHangDacTrungRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  MatHangDacTrungRepository();

  ///
  /// Get all mat-hang-dac-trungs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/mat-hang-dac-trungs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert mat-hang-dac-trung to database
  ///
  Future<ApiResponse> add(MatHangDacTrungRequest data) async {
    try {
      final response = await dioClient!.post('/mat-hang-dac-trungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update mat-hang-dac-trung to database
  ///
  Future<ApiResponse> update(MatHangDacTrungRequest data) async {
    try {
      final response = await dioClient!.put('/mat-hang-dac-trungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update mat-hang-dac-trung to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/mat-hang-dac-trungs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate mat-hang-dac-trungs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/mat-hang-dac-trungs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/mat-hang-dac-trungs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find mat-hang-dac-trung by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/mat-hang-dac-trungs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
