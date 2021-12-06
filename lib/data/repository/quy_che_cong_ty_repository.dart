import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/quy_che_cong_ty_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class QuyCheCongTyRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  QuyCheCongTyRepository();

  ///
  /// Get all quy-che-cong-tys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/quy-che-cong-tys');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert quy-che-cong-ty to database
  ///
  Future<ApiResponse> add(QuyCheCongTyRequest data) async {
    try {
      final response = await dioClient!.post('/quy-che-cong-tys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update quy-che-cong-ty to database
  ///
  Future<ApiResponse> update(QuyCheCongTyRequest data) async {
    try {
      final response = await dioClient!.put('/quy-che-cong-tys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update quy-che-cong-ty to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/quy-che-cong-tys/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate quy-che-cong-tys "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/quy-che-cong-tys/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/quy-che-cong-tys/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find quy-che-cong-ty by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/quy-che-cong-tys/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
