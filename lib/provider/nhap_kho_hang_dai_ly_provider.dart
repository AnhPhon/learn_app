import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/nhap_kho_hang_dai_ly_request.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/nhap_kho_hang_dai_ly_repository.dart';

class NhapKhoHangDaiLyProvider {
  NhapKhoHangDaiLyRepository? repository =
      GetIt.I.get<NhapKhoHangDaiLyRepository>();

  NhapKhoHangDaiLyProvider();

  ///
  /// Get all nhapKhoHangDaiLys
  ///
  Future<void> all({
    required Function(List<NhapKhoHangDaiLyResponse> nhapKhoHangDaiLys)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) =>
              NhapKhoHangDaiLyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert nhapKhoHangDaiLy to database
  ///
  Future<void> add({
    required NhapKhoHangDaiLyRequest data,
    required Function(NhapKhoHangDaiLyRequest nhapKhoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          NhapKhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update nhapKhoHangDaiLy to database
  ///
  Future<void> update({
    required NhapKhoHangDaiLyRequest data,
    required Function(NhapKhoHangDaiLyRequest nhapKhoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          NhapKhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete nhapKhoHangDaiLy to database
  ///
  Future<void> delete({
    required String id,
    required Function(NhapKhoHangDaiLyRequest nhapKhoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          NhapKhoHangDaiLyRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate nhapKhoHangDaiLys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<NhapKhoHangDaiLyResponse> nhapKhoHangDaiLys)
        onSuccess,
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
          .map((e) =>
              NhapKhoHangDaiLyResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete nhapKhoHangDaiLy to database
  ///
  Future<void> find({
    required String id,
    required Function(NhapKhoHangDaiLyResponse nhapKhoHangDaiLy) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(
          NhapKhoHangDaiLyResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
