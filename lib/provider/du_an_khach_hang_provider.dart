import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/du_an_khach_hang_request.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/du_an_khach_hang_repository.dart';

class DuAnKhachHangProvider {
  DuAnKhachHangRepository? repository = GetIt.I.get<DuAnKhachHangRepository>();

  DuAnKhachHangProvider();

  ///
  /// Get all duAnKhachHangs
  ///
  Future<void> all({
    required Function(List<DuAnKhachHangResponse> duAnKhachHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DuAnKhachHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert duAnKhachHang to database
  ///
  Future<void> add({
    required DuAnKhachHangRequest data,
    required Function(DuAnKhachHangRequest duAnKhachHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnKhachHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update duAnKhachHang to database
  ///
  Future<void> update({
    required DuAnKhachHangRequest data,
    required Function(DuAnKhachHangRequest duAnKhachHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnKhachHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete duAnKhachHang to database
  ///
  Future<void> delete({
    required String id,
    required Function(DuAnKhachHangRequest duAnKhachHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DuAnKhachHangRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate duAnKhachHangs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DuAnKhachHangResponse> duAnKhachHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) => DuAnKhachHangResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete duAnKhachHang to database
  ///
  Future<void> find({
    required String id,
    required Function(DuAnKhachHangResponse duAnKhachHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      // print('duAnKhachHang find ${results.runtimeType}');
      onSuccess(
          DuAnKhachHangResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
