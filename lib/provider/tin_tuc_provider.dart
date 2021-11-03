import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tin_tuc_request.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';

class TinTucProvider {
  TinTucRepository? repository = GetIt.I.get<TinTucRepository>();

  TinTucProvider();

  ///
  /// Get all tinTucs
  ///
  Future<void> all({
    required Function(List<TinTucResponse> tinTucs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => TinTucResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert tinTuc to database
  ///
  Future<void> add({
    required TinTucRequest data,
    required Function(TinTucRequest tinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TinTucRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update tinTuc to database
  ///
  Future<void> update({
    required TinTucRequest data,
    required Function(TinTucRequest tinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TinTucRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete tinTuc to database
  ///
  Future<void> delete({
    required String id,
    required Function(TinTucRequest tinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TinTucRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate tinTucs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TinTucResponse> tinTucs) onSuccess,
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
          .map((e) => TinTucResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete tinTuc to database
  ///
  Future<void> find({
    required String id,
    required Function(TinTucResponse tinTuc) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TinTucResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
