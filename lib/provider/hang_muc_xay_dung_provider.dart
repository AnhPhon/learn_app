import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/hang_muc_xay_dung_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/hang_muc_xay_dung_repository.dart';

class HangMucXayDungProvider {
  HangMucXayDungRepository? repository = GetIt.I.get<HangMucXayDungRepository>();

  HangMucXayDungProvider();

  ///
  /// Get all hangMucXayDungs
  ///
  Future<void> all({
    required Function(List<HangMucXayDungModel> hangMucXayDungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => HangMucXayDungModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert hangMucXayDung to database
  ///
  Future<void> add({
    required HangMucXayDungModel data,
    required Function(HangMucXayDungModel hangMucXayDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HangMucXayDungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update hangMucXayDung to database
  ///
  Future<void> update({
    required HangMucXayDungModel data,
    required Function(HangMucXayDungModel hangMucXayDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HangMucXayDungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete hangMucXayDung to database
  ///
  Future<void> delete({
    required String id,
    required HangMucXayDungModel data,
    required Function(HangMucXayDungModel hangMucXayDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HangMucXayDungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate hangMucXayDungs "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<HangMucXayDungModel> hangMucXayDungs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => HangMucXayDungModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete hangMucXayDung to database
  ///
  Future<void> find({
    required String id,
    required Function(HangMucXayDungModel hangMucXayDung) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(HangMucXayDungModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
