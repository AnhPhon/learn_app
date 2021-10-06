import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/notification_model.dart';

class NotificationRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();
  NotificationRepository();

  ///
  /// Get all notifications
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/notifications');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert notifications to database
  ///
  Future<ApiResponse> add(NotificationModel data) async {
    try {
      final response =
          await dioClient!.post('/notifications', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update notifications to database
  ///
  Future<ApiResponse> update(NotificationModel data) async {
    try {
      final response =
          await dioClient!.put('/notifications', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate categorys "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/notifications/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/notifications/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
