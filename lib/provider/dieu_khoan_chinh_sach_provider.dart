import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/dieu_khoan_chinh_sach_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/dieu_khoan_chinh_sach_repository.dart';

class DieuKhoanChinhSachProvider {
  DieuKhoanChinhSachRepository? repository = GetIt.I.get<DieuKhoanChinhSachRepository>();

  DieuKhoanChinhSachProvider();

  ///
  /// Get all dieuKhoanChinhSachs
  ///
  Future<void> all({
    required Function(List<DieuKhoanChinhSachModel> dieuKhoanChinhSachs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DieuKhoanChinhSachModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert dieuKhoanChinhSach to database
  ///
  Future<void> add({
    required DieuKhoanChinhSachModel data,
    required Function(DieuKhoanChinhSachModel dieuKhoanChinhSach) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DieuKhoanChinhSachModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update dieuKhoanChinhSach to database
  ///
  Future<void> update({
    required DieuKhoanChinhSachModel data,
    required Function(DieuKhoanChinhSachModel dieuKhoanChinhSach) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DieuKhoanChinhSachModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dieuKhoanChinhSach to database
  ///
  Future<void> delete({
    required String id,
    required DieuKhoanChinhSachModel data,
    required Function(DieuKhoanChinhSachModel dieuKhoanChinhSach) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DieuKhoanChinhSachModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate dieuKhoanChinhSachs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DieuKhoanChinhSachModel> dieuKhoanChinhSachs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DieuKhoanChinhSachModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete dieuKhoanChinhSach to database
  ///
  Future<void> find({
    required String id,
    required Function(DieuKhoanChinhSachModel dieuKhoanChinhSach) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DieuKhoanChinhSachModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
