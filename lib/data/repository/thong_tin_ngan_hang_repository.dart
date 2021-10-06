import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/thong_tin_ngan_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongTinNganHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongTinNganHangRepository();

  ///
  /// Get all thong-tin-ngan-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thong-tin-ngan-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-tin-ngan-hang to database
  ///
  Future<ApiResponse> add(ThongTinNganHangModel data) async {
    try {
      final response = await dioClient!.post('/thong-tin-ngan-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-ngan-hang to database
  ///
  Future<ApiResponse> update(ThongTinNganHangModel data) async {
    try {
      final response = await dioClient!.put('/thong-tin-ngan-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-tin-ngan-hang to database
  ///
  Future<ApiResponse> delete(String id, ThongTinNganHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/thong-tin-ngan-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-tin-ngan-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-tin-ngan-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-tin-ngan-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-tin-ngan-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-tin-ngan-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
