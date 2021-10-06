import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/loai_tai_khoan_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/loai_tai_khoan_repository.dart';

class LoaiTaiKhoanProvider {
  LoaiTaiKhoanRepository? repository = GetIt.I.get<LoaiTaiKhoanRepository>();

  LoaiTaiKhoanProvider();

  ///
  /// Get all loaiTaiKhoans
  ///
  Future<void> all({
    required Function(List<LoaiTaiKhoanModel> loaiTaiKhoans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiTaiKhoanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert loaiTaiKhoan to database
  ///
  Future<void> add({
    required LoaiTaiKhoanModel data,
    required Function(LoaiTaiKhoanModel loaiTaiKhoan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTaiKhoanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update loaiTaiKhoan to database
  ///
  Future<void> update({
    required LoaiTaiKhoanModel data,
    required Function(LoaiTaiKhoanModel loaiTaiKhoan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTaiKhoanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiTaiKhoan to database
  ///
  Future<void> delete({
    required String id,
    required LoaiTaiKhoanModel data,
    required Function(LoaiTaiKhoanModel loaiTaiKhoan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTaiKhoanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate loaiTaiKhoans "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LoaiTaiKhoanModel> loaiTaiKhoans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiTaiKhoanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiTaiKhoan to database
  ///
  Future<void> find({
    required String id,
    required Function(LoaiTaiKhoanModel loaiTaiKhoan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiTaiKhoanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}