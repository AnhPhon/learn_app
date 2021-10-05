import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/chuyen_mon_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/chuyen_mon_repository.dart';

class ChuyenMonProvider {
  ChuyenMonRepository? repository = GetIt.I.get<ChuyenMonRepository>();

  ChuyenMonProvider();

  ///
  /// Get all chuyenMons
  ///
  Future<void> all({
    required Function(List<ChuyenMonModel> chuyenMons) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ChuyenMonModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert chuyenMon to database
  ///
  Future<void> add({
    required ChuyenMonModel data,
    required Function(ChuyenMonModel chuyenMon) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChuyenMonModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update chuyenMon to database
  ///
  Future<void> update({
    required ChuyenMonModel data,
    required Function(ChuyenMonModel chuyenMon) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChuyenMonModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chuyenMon to database
  ///
  Future<void> delete({
    required String id,
    required ChuyenMonModel data,
    required Function(ChuyenMonModel chuyenMon) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChuyenMonModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate chuyenMons "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ChuyenMonModel> chuyenMons) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ChuyenMonModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chuyenMon to database
  ///
  Future<void> find({
    required String id,
    required Function(ChuyenMonModel chuyenMon) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChuyenMonModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
