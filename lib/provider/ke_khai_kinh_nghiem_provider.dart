import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/ke_khai_kinh_nghiem_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/ke_khai_kinh_nghiem_repository.dart';

class KeKhaiKinhNghiemProvider {
  KeKhaiKinhNghiemRepository? repository = GetIt.I.get<KeKhaiKinhNghiemRepository>();

  KeKhaiKinhNghiemProvider();

  ///
  /// Get all keKhaiKinhNghiems
  ///
  Future<void> all({
    required Function(List<KeKhaiKinhNghiemModel> keKhaiKinhNghiems) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => KeKhaiKinhNghiemModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert keKhaiKinhNghiem to database
  ///
  Future<void> add({
    required KeKhaiKinhNghiemModel data,
    required Function(KeKhaiKinhNghiemModel keKhaiKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KeKhaiKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update keKhaiKinhNghiem to database
  ///
  Future<void> update({
    required KeKhaiKinhNghiemModel data,
    required Function(KeKhaiKinhNghiemModel keKhaiKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KeKhaiKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete keKhaiKinhNghiem to database
  ///
  Future<void> delete({
    required String id,
    required KeKhaiKinhNghiemModel data,
    required Function(KeKhaiKinhNghiemModel keKhaiKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KeKhaiKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate keKhaiKinhNghiems "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<KeKhaiKinhNghiemModel> keKhaiKinhNghiems) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => KeKhaiKinhNghiemModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete keKhaiKinhNghiem to database
  ///
  Future<void> find({
    required String id,
    required Function(KeKhaiKinhNghiemModel keKhaiKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(KeKhaiKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}