import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/danh_sach_bao_gia_don_dich_vu_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/danh_sach_bao_gia_don_dich_vu_repository.dart';

class DanhSachBaoGiaDonDichVuProvider {
  DanhSachBaoGiaDonDichVuRepository? repository = GetIt.I.get<DanhSachBaoGiaDonDichVuRepository>();

  DanhSachBaoGiaDonDichVuProvider();

  ///
  /// Get all danhSachBaoGiaDonDichVus
  ///
  Future<void> all({
    required Function(List<DanhSachBaoGiaDonDichVuModel> danhSachBaoGiaDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachBaoGiaDonDichVuModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert danhSachBaoGiaDonDichVu to database
  ///
  Future<void> add({
    required DanhSachBaoGiaDonDichVuModel data,
    required Function(DanhSachBaoGiaDonDichVuModel danhSachBaoGiaDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update danhSachBaoGiaDonDichVu to database
  ///
  Future<void> update({
    required DanhSachBaoGiaDonDichVuModel data,
    required Function(DanhSachBaoGiaDonDichVuModel danhSachBaoGiaDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachBaoGiaDonDichVu to database
  ///
  Future<void> delete({
    required String id,
    required DanhSachBaoGiaDonDichVuModel data,
    required Function(DanhSachBaoGiaDonDichVuModel danhSachBaoGiaDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate danhSachBaoGiaDonDichVus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DanhSachBaoGiaDonDichVuModel> danhSachBaoGiaDonDichVus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => DanhSachBaoGiaDonDichVuModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete danhSachBaoGiaDonDichVu to database
  ///
  Future<void> find({
    required String id,
    required Function(DanhSachBaoGiaDonDichVuModel danhSachBaoGiaDonDichVu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DanhSachBaoGiaDonDichVuModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
