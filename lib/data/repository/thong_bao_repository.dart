import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thong_bao_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThongBaoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThongBaoRepository();

  ///
  /// Get all thong-baos
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thong-baos');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thong-bao to database
  ///
  Future<ApiResponse> add(ThongBaoRequest data) async {
    try {
      final response =
          await dioClient!.post('/thong-baos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-bao to database
  ///
  Future<ApiResponse> update(ThongBaoRequest data) async {
    try {
      final response = await dioClient!.put('/thong-baos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thong-bao to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/thong-baos/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thong-baos "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thong-baos/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thong-baos/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get count thong-baos "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> count(String doiTuong, String idTaiKhoan) async {
    try {
      String uri = '/thong-baos/count?doiTuong=$doiTuong&idTaiKhoan=$idTaiKhoan'
          .toString();

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thong-bao by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thong-baos/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
