import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_sach_bao_gia_don_dich_vu_repository.dart';

class DanhSachBaoGiaDonDichVuProvider {
  DanhSachBaoGiaDonDichVuRepository? repository =
      GetIt.I.get<DanhSachBaoGiaDonDichVuRepository>();

  DanhSachBaoGiaDonDichVuProvider();

  ///
  /// Get all danhSachBaoGiaDonDichVus
  ///
  Future<void> all({
    required Function(
            List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVus)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachBaoGiaDonDichVuResponse.fromJson(
              e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhSachBaoGiaDonDichVu to database
  ///
  Future<void> add({
    required DanhSachBaoGiaDonDichVuRequest data,
    required Function(DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVu)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    print('apiResponse $apiResponse');
    print('apiResponse ${apiResponse.response}');
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhSachBaoGiaDonDichVu to database
  ///
  Future<void> update({
    required DanhSachBaoGiaDonDichVuRequest data,
    required Function(DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVu)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachBaoGiaDonDichVu to database
  ///
  Future<void> delete({
    required String id,
    required Function(DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVu)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachBaoGiaDonDichVus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(
        List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVus)
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
          .map((e) => DanhSachBaoGiaDonDichVuResponse.fromJson(
          e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachBaoGiaDonDichVus "page": 1, "limit": 10
  ///
  Future<void> ketQuaBaoGiaPaginate({
    required int page,
    required int limit,
    required String filter,
    required Function(
        List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVus)
    onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
    await repository!.ketQuaBaoGiaPaginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) => DanhSachBaoGiaDonDichVuResponse.fromJson(
          e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachBaoGiaDonDichVu to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhSachBaoGiaDonDichVuResponse danhSachBaoGiaDonDichVu)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuResponse.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
