import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/muc_luong_du_kien_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/muc_luong_du_kien_repository.dart';

class MucLuongDuKienProvider {
  MucLuongDuKienRepository? repository = GetIt.I.get<MucLuongDuKienRepository>();

  MucLuongDuKienProvider();

  ///
  /// Get all mucLuongDuKiens
  ///
  Future<void> all({
    required Function(List<MucLuongDuKienModel> mucLuongDuKiens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => MucLuongDuKienModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert mucLuongDuKien to database
  ///
  Future<void> add({
    required MucLuongDuKienModel data,
    required Function(MucLuongDuKienModel mucLuongDuKien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MucLuongDuKienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update mucLuongDuKien to database
  ///
  Future<void> update({
    required MucLuongDuKienModel data,
    required Function(MucLuongDuKienModel mucLuongDuKien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MucLuongDuKienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete mucLuongDuKien to database
  ///
  Future<void> delete({
    required String id,
    required MucLuongDuKienModel data,
    required Function(MucLuongDuKienModel mucLuongDuKien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MucLuongDuKienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate mucLuongDuKiens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<MucLuongDuKienModel> mucLuongDuKiens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => MucLuongDuKienModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete mucLuongDuKien to database
  ///
  Future<void> find({
    required String id,
    required Function(MucLuongDuKienModel mucLuongDuKien) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(MucLuongDuKienModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
