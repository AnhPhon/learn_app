import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/hang_muc_xay_dung_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class HangMucXayDungRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  HangMucXayDungRepository();

  ///
  /// Get all hang-muc-xay-dungs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/hang-muc-xay-dungs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert hang-muc-xay-dung to database
  ///
  Future<ApiResponse> add(HangMucXayDungModel data) async {
    try {
      final response = await dioClient!.post('/hang-muc-xay-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hang-muc-xay-dung to database
  ///
  Future<ApiResponse> update(HangMucXayDungModel data) async {
    try {
      final response = await dioClient!.put('/hang-muc-xay-dungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update hang-muc-xay-dung to database
  ///
  Future<ApiResponse> delete(String id, HangMucXayDungModel data) async {
    try {
      final response =
          await dioClient!.delete('/hang-muc-xay-dungs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate hang-muc-xay-dungs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/hang-muc-xay-dungs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/hang-muc-xay-dungs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find hang-muc-xay-dung by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/hang-muc-xay-dungs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
