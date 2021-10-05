import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/tin_tuc_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TinTucRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TinTucRepository();

  ///
  /// Get all tin-tucs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/tin-tucs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert tin-tuc to database
  ///
  Future<ApiResponse> add(TinTucModel data) async {
    try {
      final response = await dioClient!.post('/tin-tucs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tin-tuc to database
  ///
  Future<ApiResponse> update(TinTucModel data) async {
    try {
      final response = await dioClient!.put('/tin-tucs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tin-tuc to database
  ///
  Future<ApiResponse> delete(String id, TinTucModel data) async {
    try {
      final response =
          await dioClient!.delete('/tin-tucs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate tin-tucs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/tin-tucs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/tin-tucs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find tin-tuc by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/tin-tucs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
