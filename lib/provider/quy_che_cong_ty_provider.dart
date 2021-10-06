import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/quy_che_cong_ty_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/quy_che_cong_ty_repository.dart';

class QuyCheCongTyProvider {
  QuyCheCongTyRepository? repository = GetIt.I.get<QuyCheCongTyRepository>();

  QuyCheCongTyProvider();

  ///
  /// Get all quyCheCongTys
  ///
  Future<void> all({
    required Function(List<QuyCheCongTyModel> quyCheCongTys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => QuyCheCongTyModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert quyCheCongTy to database
  ///
  Future<void> add({
    required QuyCheCongTyModel data,
    required Function(QuyCheCongTyModel quyCheCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(QuyCheCongTyModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update quyCheCongTy to database
  ///
  Future<void> update({
    required QuyCheCongTyModel data,
    required Function(QuyCheCongTyModel quyCheCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(QuyCheCongTyModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete quyCheCongTy to database
  ///
  Future<void> delete({
    required String id,
    required QuyCheCongTyModel data,
    required Function(QuyCheCongTyModel quyCheCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(QuyCheCongTyModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate quyCheCongTys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<QuyCheCongTyModel> quyCheCongTys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => QuyCheCongTyModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete quyCheCongTy to database
  ///
  Future<void> find({
    required String id,
    required Function(QuyCheCongTyModel quyCheCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(QuyCheCongTyModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}