import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/bang_gia_don_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/bang_gia_don_hang_repository.dart';

class BangGiaDonHangProvider {
  BangGiaDonHangRepository? repository = GetIt.I.get<BangGiaDonHangRepository>();

  BangGiaDonHangProvider();

  ///
  /// Get all bangGiaDonHangs
  ///
  Future<void> all({
    required Function(List<BangGiaDonHangModel> bangGiaDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaDonHangModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert bangGiaDonHang to database
  ///
  Future<void> add({
    required BangGiaDonHangModel data,
    required Function(BangGiaDonHangModel bangGiaDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDonHangModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update bangGiaDonHang to database
  ///
  Future<void> update({
    required BangGiaDonHangModel data,
    required Function(BangGiaDonHangModel bangGiaDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDonHangModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaDonHang to database
  ///
  Future<void> delete({
    required String id,
    required BangGiaDonHangModel data,
    required Function(BangGiaDonHangModel bangGiaDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDonHangModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate bangGiaDonHangs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BangGiaDonHangModel> bangGiaDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaDonHangModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaDonHang to database
  ///
  Future<void> find({
    required String id,
    required Function(BangGiaDonHangModel bangGiaDonHang) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDonHangModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
