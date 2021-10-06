import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/bao_cao_nhan_vien_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/bao_cao_nhan_vien_repository.dart';

class BaoCaoNhanVienProvider {
  BaoCaoNhanVienRepository? repository = GetIt.I.get<BaoCaoNhanVienRepository>();

  BaoCaoNhanVienProvider();

  ///
  /// Get all baoCaoNhanViens
  ///
  Future<void> all({
    required Function(List<BaoCaoNhanVienModel> baoCaoNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BaoCaoNhanVienModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert baoCaoNhanVien to database
  ///
  Future<void> add({
    required BaoCaoNhanVienModel data,
    required Function(BaoCaoNhanVienModel baoCaoNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BaoCaoNhanVienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update baoCaoNhanVien to database
  ///
  Future<void> update({
    required BaoCaoNhanVienModel data,
    required Function(BaoCaoNhanVienModel baoCaoNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BaoCaoNhanVienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete baoCaoNhanVien to database
  ///
  Future<void> delete({
    required String id,
    required BaoCaoNhanVienModel data,
    required Function(BaoCaoNhanVienModel baoCaoNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BaoCaoNhanVienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate baoCaoNhanViens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BaoCaoNhanVienModel> baoCaoNhanViens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BaoCaoNhanVienModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete baoCaoNhanVien to database
  ///
  Future<void> find({
    required String id,
    required Function(BaoCaoNhanVienModel baoCaoNhanVien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BaoCaoNhanVienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
