import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_tho_thau_bao_gia_request.dart';
import 'package:template/data/model/response/danh_sach_tho_thau_bao_gia_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_sach_tho_thau_bao_gia_repository.dart';

class DanhSachThoThauBaoGiaProvider {
  DanhSachThoThauBaoGiaRepository? repository = GetIt.I.get<DanhSachThoThauBaoGiaRepository>();

  DanhSachThoThauBaoGiaProvider();

  ///
  /// Get all danhSachThoThauBaoGias
  ///
  Future<void> all({
    required Function(List<DanhSachThoThauBaoGiaResponse> danhSachThoThauBaoGias) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachThoThauBaoGiaResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhSachThoThauBaoGia to database
  ///
  Future<void> add({
    required DanhSachThoThauBaoGiaRequest data,
    required Function(DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGia) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachThoThauBaoGiaRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhSachThoThauBaoGia to database
  ///
  Future<void> update({
    required DanhSachThoThauBaoGiaRequest data,
    required Function(DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGia) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachThoThauBaoGiaRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachThoThauBaoGia to database
  ///
  Future<void> delete({
    required String id,
    required Function(DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGia) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachThoThauBaoGiaRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachThoThauBaoGias "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhSachThoThauBaoGiaResponse> danhSachThoThauBaoGias) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachThoThauBaoGiaResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachThoThauBaoGia to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhSachThoThauBaoGiaResponse danhSachThoThauBaoGia) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachThoThauBaoGiaResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
