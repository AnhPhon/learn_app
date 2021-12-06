import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/lien_he_cong_ty_request.dart';
import 'package:template/data/model/response/lien_he_cong_ty_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/lien_he_cong_ty_repository.dart';

class LienHeCongTyProvider {
  LienHeCongTyRepository? repository = GetIt.I.get<LienHeCongTyRepository>();

  LienHeCongTyProvider();

  ///
  /// Get all lienHeCongTys
  ///
  Future<void> all({
    required Function(List<LienHeCongTyResponse> lienHeCongTys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LienHeCongTyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert lienHeCongTy to database
  ///
  Future<void> add({
    required LienHeCongTyRequest data,
    required Function(LienHeCongTyRequest lienHeCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LienHeCongTyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update lienHeCongTy to database
  ///
  Future<void> update({
    required LienHeCongTyRequest data,
    required Function(LienHeCongTyRequest lienHeCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LienHeCongTyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete lienHeCongTy to database
  ///
  Future<void> delete({
    required String id,
    required Function(LienHeCongTyRequest lienHeCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LienHeCongTyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate lienHeCongTys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LienHeCongTyResponse> lienHeCongTys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) => LienHeCongTyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete lienHeCongTy to database
  ///
  Future<void> find({
    required String id,
    required Function(LienHeCongTyResponse lienHeCongTy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LienHeCongTyResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
