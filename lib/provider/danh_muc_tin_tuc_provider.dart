import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/danh_muc_tin_tuc_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';

class DanhMucTinTucProvider {
  DanhMucTinTucRepository? repository = GetIt.I.get<DanhMucTinTucRepository>();

  DanhMucTinTucProvider();

  ///
  /// Get all danhMucTinTucs
  ///
  Future<void> all({
    required Function(List<DanhMucTinTucModel> danhMucTinTucs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhMucTinTucModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhMucTinTuc to database
  ///
  Future<void> add({
    required DanhMucTinTucModel data,
    required Function(DanhMucTinTucModel danhMucTinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhMucTinTucModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhMucTinTuc to database
  ///
  Future<void> update({
    required DanhMucTinTucModel data,
    required Function(DanhMucTinTucModel danhMucTinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhMucTinTucModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhMucTinTuc to database
  ///
  Future<void> delete({
    required String id,
    required DanhMucTinTucModel data,
    required Function(DanhMucTinTucModel danhMucTinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhMucTinTucModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhMucTinTucs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhMucTinTucModel> danhMucTinTucs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DanhMucTinTucModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhMucTinTuc to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhMucTinTucModel danhMucTinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhMucTinTucModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
