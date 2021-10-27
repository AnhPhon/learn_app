import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dia_diem_dang_ky_lam_viec_request.dart';
import 'package:template/data/model/response/dia_diem_dang_ky_lam_viec_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/dia_diem_dang_ky_lam_viec_repository.dart';

class DiaDiemDangKyLamViecProvider {
  DiaDiemDangKyLamViecRepository? repository = GetIt.I.get<DiaDiemDangKyLamViecRepository>();

  DiaDiemDangKyLamViecProvider();

  ///
  /// Get all diaDiemDangKyLamViecs
  ///
  Future<void> all({
    required Function(List<DiaDiemDangKyLamViecResponse> diaDiemDangKyLamViecs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DiaDiemDangKyLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert diaDiemDangKyLamViec to database
  ///
  Future<void> add({
    required DiaDiemDangKyLamViecRequest data,
    required Function(DiaDiemDangKyLamViecRequest diaDiemDangKyLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DiaDiemDangKyLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update diaDiemDangKyLamViec to database
  ///
  Future<void> update({
    required DiaDiemDangKyLamViecRequest data,
    required Function(DiaDiemDangKyLamViecRequest diaDiemDangKyLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DiaDiemDangKyLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete diaDiemDangKyLamViec to database
  ///
  Future<void> delete({
    required String id,
    required Function(DiaDiemDangKyLamViecRequest diaDiemDangKyLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DiaDiemDangKyLamViecRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate diaDiemDangKyLamViecs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DiaDiemDangKyLamViecResponse> diaDiemDangKyLamViecs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DiaDiemDangKyLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete diaDiemDangKyLamViec to database
  ///
  Future<void> find({
    required String id,
    required Function(DiaDiemDangKyLamViecResponse diaDiemDangKyLamViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DiaDiemDangKyLamViecResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
