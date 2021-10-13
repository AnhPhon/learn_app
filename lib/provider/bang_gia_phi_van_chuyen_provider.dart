import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bang_gia_phi_van_chuyen_request.dart';
import 'package:template/data/model/response/bang_gia_phi_van_chuyen_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/bang_gia_phi_van_chuyen_repository.dart';

class BangGiaPhiVanChuyenProvider {
  BangGiaPhiVanChuyenRepository? repository = GetIt.I.get<BangGiaPhiVanChuyenRepository>();

  BangGiaPhiVanChuyenProvider();

  ///
  /// Get all bangGiaPhiVanChuyens
  ///
  Future<void> all({
    required Function(List<BangGiaPhiVanChuyenResponse> bangGiaPhiVanChuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaPhiVanChuyenResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert bangGiaPhiVanChuyen to database
  ///
  Future<void> add({
    required BangGiaPhiVanChuyenRequest data,
    required Function(BangGiaPhiVanChuyenRequest bangGiaPhiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaPhiVanChuyenRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update bangGiaPhiVanChuyen to database
  ///
  Future<void> update({
    required BangGiaPhiVanChuyenRequest data,
    required Function(BangGiaPhiVanChuyenRequest bangGiaPhiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaPhiVanChuyenRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaPhiVanChuyen to database
  ///
  Future<void> delete({
    required String id,
    required Function(BangGiaPhiVanChuyenRequest bangGiaPhiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaPhiVanChuyenRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate bangGiaPhiVanChuyens "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BangGiaPhiVanChuyenResponse> bangGiaPhiVanChuyens) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BangGiaPhiVanChuyenResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete bangGiaPhiVanChuyen to database
  ///
  Future<void> find({
    required String id,
    required Function(BangGiaPhiVanChuyenResponse bangGiaPhiVanChuyen) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BangGiaPhiVanChuyenResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
