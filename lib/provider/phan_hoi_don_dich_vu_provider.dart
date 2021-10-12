import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/phan_hoi_don_dich_vu_repository.dart';

class PhanHoiDonDichVuProvider {
  PhanHoiDonDichVuRepository? repository = GetIt.I.get<PhanHoiDonDichVuRepository>();

  PhanHoiDonDichVuProvider();

  ///
  /// Get all phanHoiDonDichVus
  ///
  Future<void> all({
    required Function(List<PhanHoiDonDichVuResponse> phanHoiDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => PhanHoiDonDichVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert phanHoiDonDichVu to database
  ///
  Future<void> add({
    required PhanHoiDonDichVuRequest data,
    required Function(PhanHoiDonDichVuRequest phanHoiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PhanHoiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update phanHoiDonDichVu to database
  ///
  Future<void> update({
    required PhanHoiDonDichVuRequest data,
    required Function(PhanHoiDonDichVuRequest phanHoiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PhanHoiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete phanHoiDonDichVu to database
  ///
  Future<void> delete({
    required String id,
    required Function(PhanHoiDonDichVuRequest phanHoiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PhanHoiDonDichVuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate phanHoiDonDichVus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<PhanHoiDonDichVuResponse> phanHoiDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => PhanHoiDonDichVuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete phanHoiDonDichVu to database
  ///
  Future<void> find({
    required String id,
    required Function(PhanHoiDonDichVuResponse phanHoiDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PhanHoiDonDichVuResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
