import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/so_nam_kinh_nghiem_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class SoNamKinhNghiemRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  SoNamKinhNghiemRepository();

  ///
  /// Get all so-nam-kinh-nghiems
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/so-nam-kinh-nghiems');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert so-nam-kinh-nghiem to database
  ///
  Future<ApiResponse> add(SoNamKinhNghiemModel data) async {
    try {
      final response = await dioClient!.post('/so-nam-kinh-nghiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update so-nam-kinh-nghiem to database
  ///
  Future<ApiResponse> update(SoNamKinhNghiemModel data) async {
    try {
      final response = await dioClient!.put('/so-nam-kinh-nghiems', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update so-nam-kinh-nghiem to database
  ///
  Future<ApiResponse> delete(String id, SoNamKinhNghiemModel data) async {
    try {
      final response =
          await dioClient!.delete('/so-nam-kinh-nghiems/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate so-nam-kinh-nghiems "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/so-nam-kinh-nghiems/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/so-nam-kinh-nghiems/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find so-nam-kinh-nghiem by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/so-nam-kinh-nghiems/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
