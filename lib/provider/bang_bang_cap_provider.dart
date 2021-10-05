import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/bang_bang_cap_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/bang_bang_cap_repository.dart';

class BangBangCapProvider {
  BangBangCapRepository? repository = GetIt.I.get<BangBangCapRepository>();

  BangBangCapProvider();

  ///
  /// Get all bangBangCaps
  ///
  Future<void> all({
    required Function(List<BangBangCapModel> bangBangCaps) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BangBangCapModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert bangBangCap to database
  ///
  Future<void> add({
    required BangBangCapModel data,
    required Function(BangBangCapModel bangBangCap) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangBangCapModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update bangBangCap to database
  ///
  Future<void> update({
    required BangBangCapModel data,
    required Function(BangBangCapModel bangBangCap) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangBangCapModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangBangCap to database
  ///
  Future<void> delete({
    required String id,
    required BangBangCapModel data,
    required Function(BangBangCapModel bangBangCap) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangBangCapModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate bangBangCaps "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BangBangCapModel> bangBangCaps) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BangBangCapModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangBangCap to database
  ///
  Future<void> find({
    required String id,
    required Function(BangBangCapModel bangBangCap) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangBangCapModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
