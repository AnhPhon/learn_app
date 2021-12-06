import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/thong_bao_request.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/thong_bao_repository.dart';

class ThongBaoProvider {
  ThongBaoRepository? repository = GetIt.I.get<ThongBaoRepository>();

  ThongBaoProvider();

  ///
  /// Get all thongBaos
  ///
  Future<void> all({
    required Function(List<ThongBaoResponse> thongBaos) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ThongBaoResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert thongBao to database
  ///
  Future<void> add({
    required ThongBaoRequest data,
    required Function(ThongBaoRequest thongBao) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongBaoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update thongBao to database
  ///
  Future<void> update({
    required ThongBaoRequest data,
    required Function(ThongBaoRequest thongBao) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongBaoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongBao to database
  ///
  Future<void> delete({
    required String id,
    required Function(ThongBaoRequest thongBao) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongBaoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thongBaos "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ThongBaoResponse> thongBaos) onSuccess,
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
          .map((e) => ThongBaoResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate thongBaos "page": 1, "limit": 10
  ///
  Future<void> count({
    required String doiTuong,
    required String idTaiKhoan,
    required Function(dynamic thongBaos) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.count(doiTuong, idTaiKhoan);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data as dynamic
          : [];
      onSuccess(results.map((e) => e as dynamic).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete thongBao to database
  ///
  Future<void> find({
    required String id,
    required Function(ThongBaoResponse thongBao) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ThongBaoResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
