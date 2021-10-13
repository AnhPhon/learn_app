import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/ngoai_ngu_request.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/ngoai_ngu_repository.dart';

class NgoaiNguProvider {
  NgoaiNguRepository? repository = GetIt.I.get<NgoaiNguRepository>();

  NgoaiNguProvider();

  ///
  /// Get all ngoaiNgus
  ///
  Future<void> all({
    required Function(List<NgoaiNguResponse> ngoaiNgus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => NgoaiNguResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert ngoaiNgu to database
  ///
  Future<void> add({
    required NgoaiNguRequest data,
    required Function(NgoaiNguRequest ngoaiNgu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NgoaiNguRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update ngoaiNgu to database
  ///
  Future<void> update({
    required NgoaiNguRequest data,
    required Function(NgoaiNguRequest ngoaiNgu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NgoaiNguRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete ngoaiNgu to database
  ///
  Future<void> delete({
    required String id,
    required Function(NgoaiNguRequest ngoaiNgu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NgoaiNguRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate ngoaiNgus "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<NgoaiNguResponse> ngoaiNgus) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => NgoaiNguResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete ngoaiNgu to database
  ///
  Future<void> find({
    required String id,
    required Function(NgoaiNguResponse ngoaiNgu) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NgoaiNguResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
