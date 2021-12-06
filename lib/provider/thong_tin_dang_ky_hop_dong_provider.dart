import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/thong_tin_dang_ky_hop_dong_request.dart';
import 'package:template/data/model/response/thong_tin_dang_ky_hop_dong_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/thong_tin_dang_ky_hop_dong_repository.dart';

class ThongTinDangKyHopDongProvider {
  ThongTinDangKyHopDongRepository? repository =
      GetIt.I.get<ThongTinDangKyHopDongRepository>();

  ThongTinDangKyHopDongProvider();

  ///
  /// Get all thongTinDangKyHopDongs
  ///
  Future<void> all({
    required Function(
            List<ThongTinDangKyHopDongResponse> thongTinDangKyHopDongs)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) =>
              ThongTinDangKyHopDongResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert thongTinDangKyHopDong to database
  ///
  Future<void> add({
    required ThongTinDangKyHopDongRequest data,
    required Function(ThongTinDangKyHopDongRequest thongTinDangKyHopDong)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongTinDangKyHopDongRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update thongTinDangKyHopDong to database
  ///
  Future<void> update({
    required ThongTinDangKyHopDongRequest data,
    required Function(ThongTinDangKyHopDongRequest thongTinDangKyHopDong)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongTinDangKyHopDongRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongTinDangKyHopDong to database
  ///
  Future<void> delete({
    required String id,
    required Function(ThongTinDangKyHopDongRequest thongTinDangKyHopDong)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongTinDangKyHopDongRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thongTinDangKyHopDongs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(
            List<ThongTinDangKyHopDongResponse> thongTinDangKyHopDongs)
        onSuccess,
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
          .map((e) =>
              ThongTinDangKyHopDongResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongTinDangKyHopDong to database
  ///
  Future<void> find({
    required String id,
    required Function(ThongTinDangKyHopDongResponse thongTinDangKyHopDong)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongTinDangKyHopDongResponse.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
