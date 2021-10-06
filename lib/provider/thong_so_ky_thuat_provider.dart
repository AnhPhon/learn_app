import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/thong_so_ky_thuat_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/thong_so_ky_thuat_repository.dart';

class ThongSoKyThuatProvider {
  ThongSoKyThuatRepository? repository = GetIt.I.get<ThongSoKyThuatRepository>();

  ThongSoKyThuatProvider();

  ///
  /// Get all thongSoKyThuats
  ///
  Future<void> all({
    required Function(List<ThongSoKyThuatModel> thongSoKyThuats) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ThongSoKyThuatModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert thongSoKyThuat to database
  ///
  Future<void> add({
    required ThongSoKyThuatModel data,
    required Function(ThongSoKyThuatModel thongSoKyThuat) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongSoKyThuatModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update thongSoKyThuat to database
  ///
  Future<void> update({
    required ThongSoKyThuatModel data,
    required Function(ThongSoKyThuatModel thongSoKyThuat) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongSoKyThuatModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongSoKyThuat to database
  ///
  Future<void> delete({
    required String id,
    required ThongSoKyThuatModel data,
    required Function(ThongSoKyThuatModel thongSoKyThuat) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongSoKyThuatModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thongSoKyThuats "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ThongSoKyThuatModel> thongSoKyThuats) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ThongSoKyThuatModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongSoKyThuat to database
  ///
  Future<void> find({
    required String id,
    required Function(ThongSoKyThuatModel thongSoKyThuat) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongSoKyThuatModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}