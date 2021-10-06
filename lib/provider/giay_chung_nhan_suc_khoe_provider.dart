import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/giay_chung_nhan_suc_khoe_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/giay_chung_nhan_suc_khoe_repository.dart';

class GiayChungNhanSucKhoeProvider {
  GiayChungNhanSucKhoeRepository? repository = GetIt.I.get<GiayChungNhanSucKhoeRepository>();

  GiayChungNhanSucKhoeProvider();

  ///
  /// Get all giayChungNhanSucKhoes
  ///
  Future<void> all({
    required Function(List<GiayChungNhanSucKhoeModel> giayChungNhanSucKhoes) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => GiayChungNhanSucKhoeModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert giayChungNhanSucKhoe to database
  ///
  Future<void> add({
    required GiayChungNhanSucKhoeModel data,
    required Function(GiayChungNhanSucKhoeModel giayChungNhanSucKhoe) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(GiayChungNhanSucKhoeModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update giayChungNhanSucKhoe to database
  ///
  Future<void> update({
    required GiayChungNhanSucKhoeModel data,
    required Function(GiayChungNhanSucKhoeModel giayChungNhanSucKhoe) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(GiayChungNhanSucKhoeModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete giayChungNhanSucKhoe to database
  ///
  Future<void> delete({
    required String id,
    required GiayChungNhanSucKhoeModel data,
    required Function(GiayChungNhanSucKhoeModel giayChungNhanSucKhoe) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(GiayChungNhanSucKhoeModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate giayChungNhanSucKhoes "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<GiayChungNhanSucKhoeModel> giayChungNhanSucKhoes) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => GiayChungNhanSucKhoeModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete giayChungNhanSucKhoe to database
  ///
  Future<void> find({
    required String id,
    required Function(GiayChungNhanSucKhoeModel giayChungNhanSucKhoe) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(GiayChungNhanSucKhoeModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}