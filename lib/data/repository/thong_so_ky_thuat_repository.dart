import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/thong_so_ky_thuat_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongSoKyThuatRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongSoKyThuatRepository();

  ///
  /// Get all thong-so-ky-thuats
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thong-so-ky-thuats');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-so-ky-thuat to database
  ///
  Future<ApiResponse> add(ThongSoKyThuatModel data) async {
    try {
      final response = await dioClient!.post('/thong-so-ky-thuats', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-so-ky-thuat to database
  ///
  Future<ApiResponse> update(ThongSoKyThuatModel data) async {
    try {
      final response = await dioClient!.put('/thong-so-ky-thuats', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-so-ky-thuat to database
  ///
  Future<ApiResponse> delete(String id, ThongSoKyThuatModel data) async {
    try {
      final response =
          await dioClient!.delete('/thong-so-ky-thuats/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-so-ky-thuats "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-so-ky-thuats/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-so-ky-thuats/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-so-ky-thuat by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-so-ky-thuats/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
