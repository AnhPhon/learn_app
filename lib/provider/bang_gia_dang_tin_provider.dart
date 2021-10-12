import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bang_gia_dang_tin_request.dart';
import 'package:template/data/model/response/bang_gia_dang_tin_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/bang_gia_dang_tin_repository.dart';

class BangGiaDangTinProvider {
  BangGiaDangTinRepository? repository = GetIt.I.get<BangGiaDangTinRepository>();

  BangGiaDangTinProvider();

  ///
  /// Get all bangGiaDangTins
  ///
  Future<void> all({
    required Function(List<BangGiaDangTinResponse> bangGiaDangTins) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaDangTinResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert bangGiaDangTin to database
  ///
  Future<void> add({
    required BangGiaDangTinRequest data,
    required Function(BangGiaDangTinRequest bangGiaDangTin) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDangTinRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update bangGiaDangTin to database
  ///
  Future<void> update({
    required BangGiaDangTinRequest data,
    required Function(BangGiaDangTinRequest bangGiaDangTin) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDangTinRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaDangTin to database
  ///
  Future<void> delete({
    required String id,
    required Function(BangGiaDangTinRequest bangGiaDangTin) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDangTinRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate bangGiaDangTins "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BangGiaDangTinResponse> bangGiaDangTins) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaDangTinResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaDangTin to database
  ///
  Future<void> find({
    required String id,
    required Function(BangGiaDangTinResponse bangGiaDangTin) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaDangTinResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
