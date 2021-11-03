import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_xem_tuyen_dung_request.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/danh_sach_xem_tuyen_dung_reponse.dart';
import 'package:template/data/repository/danh_sach_xem_tuyen_dung_repository.dart';

class DanhSachXemTuyenDungProvider {
  DanhSachXemTuyenDungRepository? repository =
      GetIt.I.get<DanhSachXemTuyenDungRepository>();

  DanhSachXemTuyenDungProvider();

  ///
  /// Get all danhSachXemTuyenDung
  ///
  Future<void> all({
    required Function(List<DanhSachXemTuyenDungResponse> danhSachXemTuyenDung)
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
              DanhSachXemTuyenDungResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert dangKyHopDongSBS to database
  ///
  Future<void> add({
    required DanhSachXemTuyenDungRequest data,
    required Function(DanhSachXemTuyenDungRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachXemTuyenDungRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update dangKyHopDongSBS to database
  ///
  Future<void> update({
    required DanhSachXemTuyenDungRequest data,
    required Function(DanhSachXemTuyenDungRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachXemTuyenDungRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dangKyHopDongSBS to database
  ///
  Future<void> delete({
    required String id,
    required Function(DanhSachXemTuyenDungRequest dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachXemTuyenDungRequest.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachXemTuyenDung "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhSachXemTuyenDungResponse> danhSachXemTuyenDung)
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
              DanhSachXemTuyenDungResponse.fromJson(e as Map<String, dynamic>))
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
    required Function(DanhSachXemTuyenDungResponse dangKyHopDongSBS) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachXemTuyenDungResponse.fromJson(
          results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
