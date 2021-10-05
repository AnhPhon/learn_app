import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/tuyen_dung_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TuyenDungRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TuyenDungRepository();

  ///
  /// Get all tuyen-dungs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/tuyen-dungs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert tuyen-dung to database
  ///
  Future<ApiResponse> add(TuyenDungModel data) async {
    try {
      final response = await dioClient!.post('/tuyen-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tuyen-dung to database
  ///
  Future<ApiResponse> update(TuyenDungModel data) async {
    try {
      final response = await dioClient!.put('/tuyen-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tuyen-dung to database
  ///
  Future<ApiResponse> delete(String id, TuyenDungModel data) async {
    try {
      final response =
          await dioClient!.delete('/tuyen-dungs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate tuyen-dungs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/tuyen-dungs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/tuyen-dungs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find tuyen-dung by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/tuyen-dungs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
