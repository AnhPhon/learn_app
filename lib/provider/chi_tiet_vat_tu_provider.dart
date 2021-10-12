import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_vat_tu_request.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/chi_tiet_vat_tu_repository.dart';

class ChiTietVatTuProvider {
  ChiTietVatTuRepository? repository = GetIt.I.get<ChiTietVatTuRepository>();

  ChiTietVatTuProvider();

  ///
  /// Get all chiTietVatTus
  ///
  Future<void> all({
    required Function(List<ChiTietVatTuResponse> chiTietVatTus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ChiTietVatTuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert chiTietVatTu to database
  ///
  Future<void> add({
    required ChiTietVatTuRequest data,
    required Function(ChiTietVatTuRequest chiTietVatTu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChiTietVatTuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update chiTietVatTu to database
  ///
  Future<void> update({
    required ChiTietVatTuRequest data,
    required Function(ChiTietVatTuRequest chiTietVatTu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChiTietVatTuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chiTietVatTu to database
  ///
  Future<void> delete({
    required String id,
    required Function(ChiTietVatTuRequest chiTietVatTu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChiTietVatTuRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate chiTietVatTus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ChiTietVatTuResponse> chiTietVatTus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ChiTietVatTuResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete chiTietVatTu to database
  ///
  Future<void> find({
    required String id,
    required Function(ChiTietVatTuResponse chiTietVatTu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ChiTietVatTuResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
