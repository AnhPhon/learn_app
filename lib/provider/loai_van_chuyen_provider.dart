import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/loai_van_chuyen_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/loai_van_chuyen_repository.dart';

class LoaiVanChuyenProvider {
  LoaiVanChuyenRepository? repository = GetIt.I.get<LoaiVanChuyenRepository>();

  LoaiVanChuyenProvider();

  ///
  /// Get all loaiVanChuyens
  ///
  Future<void> all({
    required Function(List<LoaiVanChuyenModel> loaiVanChuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiVanChuyenModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert loaiVanChuyen to database
  ///
  Future<void> add({
    required LoaiVanChuyenModel data,
    required Function(LoaiVanChuyenModel loaiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiVanChuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update loaiVanChuyen to database
  ///
  Future<void> update({
    required LoaiVanChuyenModel data,
    required Function(LoaiVanChuyenModel loaiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiVanChuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiVanChuyen to database
  ///
  Future<void> delete({
    required String id,
    required LoaiVanChuyenModel data,
    required Function(LoaiVanChuyenModel loaiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiVanChuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate loaiVanChuyens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LoaiVanChuyenModel> loaiVanChuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiVanChuyenModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiVanChuyen to database
  ///
  Future<void> find({
    required String id,
    required Function(LoaiVanChuyenModel loaiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiVanChuyenModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
