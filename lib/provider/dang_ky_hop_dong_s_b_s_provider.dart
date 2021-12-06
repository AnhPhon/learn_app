import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_hop_dong_s_b_s_request.dart';
import 'package:template/data/model/response/dang_ky_hop_dong_s_b_s_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/dang_ky_hop_dong_s_b_s_repository.dart';

class DangKyHopDongSBSProvider {
  DangKyHopDongSBSRepository? repository =
      GetIt.I.get<DangKyHopDongSBSRepository>();

  DangKyHopDongSBSProvider();

  ///
  /// Get all dangKyHopDongSBSs
  ///
  Future<void> all({
    required Function(List<DangKyHopDongSBSResponse> dangKyHopDongSBSs)
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
              DangKyHopDongSBSResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert dangKyHopDongSBS to database
  ///
  Future<void> add({
    required DangKyHopDongSBSRequest data,
    required Function(DangKyHopDongSBSRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DangKyHopDongSBSRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update dangKyHopDongSBS to database
  ///
  Future<void> update({
    required DangKyHopDongSBSRequest data,
    required Function(DangKyHopDongSBSRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DangKyHopDongSBSRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dangKyHopDongSBS to database
  ///
  Future<void> delete({
    required String id,
    required Function(DangKyHopDongSBSRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DangKyHopDongSBSRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate dangKyHopDongSBSs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DangKyHopDongSBSResponse> dangKyHopDongSBSs)
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
              DangKyHopDongSBSResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dangKyHopDongSBS to database
  ///
  Future<void> find({
    required String id,
    required Function(DangKyHopDongSBSResponse dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          DangKyHopDongSBSResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
