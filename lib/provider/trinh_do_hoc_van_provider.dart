import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/trinh_do_hoc_van_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/trinh_do_hoc_van_repository.dart';

class TrinhDoHocVanProvider {
  TrinhDoHocVanRepository? repository = GetIt.I.get<TrinhDoHocVanRepository>();

  TrinhDoHocVanProvider();

  ///
  /// Get all trinhDoHocVans
  ///
  Future<void> all({
    required Function(List<TrinhDoHocVanModel> trinhDoHocVans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TrinhDoHocVanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert trinhDoHocVan to database
  ///
  Future<void> add({
    required TrinhDoHocVanModel data,
    required Function(TrinhDoHocVanModel trinhDoHocVan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrinhDoHocVanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update trinhDoHocVan to database
  ///
  Future<void> update({
    required TrinhDoHocVanModel data,
    required Function(TrinhDoHocVanModel trinhDoHocVan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrinhDoHocVanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trinhDoHocVan to database
  ///
  Future<void> delete({
    required String id,
    required TrinhDoHocVanModel data,
    required Function(TrinhDoHocVanModel trinhDoHocVan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrinhDoHocVanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate trinhDoHocVans "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TrinhDoHocVanModel> trinhDoHocVans) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => TrinhDoHocVanModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete trinhDoHocVan to database
  ///
  Future<void> find({
    required String id,
    required Function(TrinhDoHocVanModel trinhDoHocVan) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TrinhDoHocVanModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
