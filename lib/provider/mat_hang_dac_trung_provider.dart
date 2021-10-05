import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/mat_hang_dac_trung_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/mat_hang_dac_trung_repository.dart';

class MatHangDacTrungProvider {
  MatHangDacTrungRepository? repository = GetIt.I.get<MatHangDacTrungRepository>();

  MatHangDacTrungProvider();

  ///
  /// Get all matHangDacTrungs
  ///
  Future<void> all({
    required Function(List<MatHangDacTrungModel> matHangDacTrungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => MatHangDacTrungModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert matHangDacTrung to database
  ///
  Future<void> add({
    required MatHangDacTrungModel data,
    required Function(MatHangDacTrungModel matHangDacTrung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MatHangDacTrungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update matHangDacTrung to database
  ///
  Future<void> update({
    required MatHangDacTrungModel data,
    required Function(MatHangDacTrungModel matHangDacTrung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MatHangDacTrungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete matHangDacTrung to database
  ///
  Future<void> delete({
    required String id,
    required MatHangDacTrungModel data,
    required Function(MatHangDacTrungModel matHangDacTrung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MatHangDacTrungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate matHangDacTrungs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<MatHangDacTrungModel> matHangDacTrungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => MatHangDacTrungModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete matHangDacTrung to database
  ///
  Future<void> find({
    required String id,
    required Function(MatHangDacTrungModel matHangDacTrung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MatHangDacTrungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
