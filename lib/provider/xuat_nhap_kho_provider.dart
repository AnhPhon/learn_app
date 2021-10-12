import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/xuat_nhap_kho_request.dart';
import 'package:template/data/model/response/xuat_nhap_kho_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/xuat_nhap_kho_repository.dart';

class XuatNhapKhoProvider {
  XuatNhapKhoRepository? repository = GetIt.I.get<XuatNhapKhoRepository>();

  XuatNhapKhoProvider();

  ///
  /// Get all xuatNhapKhos
  ///
  Future<void> all({
    required Function(List<XuatNhapKhoResponse> xuatNhapKhos) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => XuatNhapKhoResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert xuatNhapKho to database
  ///
  Future<void> add({
    required XuatNhapKhoRequest data,
    required Function(XuatNhapKhoRequest xuatNhapKho) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(XuatNhapKhoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update xuatNhapKho to database
  ///
  Future<void> update({
    required XuatNhapKhoRequest data,
    required Function(XuatNhapKhoRequest xuatNhapKho) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(XuatNhapKhoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete xuatNhapKho to database
  ///
  Future<void> delete({
    required String id,
    required Function(XuatNhapKhoRequest xuatNhapKho) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(XuatNhapKhoRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate xuatNhapKhos "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<XuatNhapKhoResponse> xuatNhapKhos) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => XuatNhapKhoResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete xuatNhapKho to database
  ///
  Future<void> find({
    required String id,
    required Function(XuatNhapKhoResponse xuatNhapKho) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(XuatNhapKhoResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
