import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/lien_he_cong_ty_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LienHeCongTyRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LienHeCongTyRepository();

  ///
  /// Get all lien-he-cong-tys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/lien-he-cong-tys');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert lien-he-cong-ty to database
  ///
  Future<ApiResponse> add(LienHeCongTyModel data) async {
    try {
      final response = await dioClient!.post('/lien-he-cong-tys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lien-he-cong-ty to database
  ///
  Future<ApiResponse> update(LienHeCongTyModel data) async {
    try {
      final response = await dioClient!.put('/lien-he-cong-tys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lien-he-cong-ty to database
  ///
  Future<ApiResponse> delete(String id, LienHeCongTyModel data) async {
    try {
      final response =
          await dioClient!.delete('/lien-he-cong-tys/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate lien-he-cong-tys "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/lien-he-cong-tys/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/lien-he-cong-tys/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find lien-he-cong-ty by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/lien-he-cong-tys/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
