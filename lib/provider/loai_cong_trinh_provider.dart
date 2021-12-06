import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/loai_cong_trinh_request.dart';
import 'package:template/data/model/response/loai_cong_trinh_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/loai_cong_trinh_repository.dart';

class LoaiCongTrinhProvider {
  LoaiCongTrinhRepository? repository = GetIt.I.get<LoaiCongTrinhRepository>();

  LoaiCongTrinhProvider();

  ///
  /// Get all loaiCongViecs
  ///
  Future<void> all({
    required Function(List<LoaiCongTrinhResponse> loaiCongViecs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => LoaiCongTrinhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert loaiCongViec to database
  ///
  Future<void> add({
    required LoaiCongTrinhRequest data,
    required Function(LoaiCongTrinhRequest loaiCongViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiCongTrinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update loaiCongViec to database
  ///
  Future<void> update({
    required LoaiCongTrinhRequest data,
    required Function(LoaiCongTrinhRequest loaiCongViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiCongTrinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiCongViec to database
  ///
  Future<void> delete({
    required String id,
    required Function(LoaiCongTrinhRequest loaiCongViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiCongTrinhRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate loaiCongViecs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<LoaiCongTrinhResponse> loaiCongViecs) onSuccess,
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
          .map((e) => LoaiCongTrinhResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete loaiCongViec to database
  ///
  Future<void> find({
    required String id,
    required Function(LoaiCongTrinhResponse loaiCongViec) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(LoaiCongTrinhResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
