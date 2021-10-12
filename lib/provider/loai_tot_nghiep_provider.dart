import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/loai_tot_nghiep_request.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/loai_tot_nghiep_repository.dart';

class LoaiTotNghiepProvider {
  LoaiTotNghiepRepository? repository = GetIt.I.get<LoaiTotNghiepRepository>();

  LoaiTotNghiepProvider();

  ///
  /// Get all loaiTotNghieps
  ///
  Future<void> all({
    required Function(List<LoaiTotNghiepResponse> loaiTotNghieps) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiTotNghiepResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert loaiTotNghiep to database
  ///
  Future<void> add({
    required LoaiTotNghiepRequest data,
    required Function(LoaiTotNghiepRequest loaiTotNghiep) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTotNghiepRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update loaiTotNghiep to database
  ///
  Future<void> update({
    required LoaiTotNghiepRequest data,
    required Function(LoaiTotNghiepRequest loaiTotNghiep) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTotNghiepRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiTotNghiep to database
  ///
  Future<void> delete({
    required String id,
    required Function(LoaiTotNghiepRequest loaiTotNghiep) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTotNghiepRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate loaiTotNghieps "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LoaiTotNghiepResponse> loaiTotNghieps) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiTotNghiepResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiTotNghiep to database
  ///
  Future<void> find({
    required String id,
    required Function(LoaiTotNghiepResponse loaiTotNghiep) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTotNghiepResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
