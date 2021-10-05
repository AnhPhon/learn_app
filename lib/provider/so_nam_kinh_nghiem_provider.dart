import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/so_nam_kinh_nghiem_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/so_nam_kinh_nghiem_repository.dart';

class SoNamKinhNghiemProvider {
  SoNamKinhNghiemRepository? repository = GetIt.I.get<SoNamKinhNghiemRepository>();

  SoNamKinhNghiemProvider();

  ///
  /// Get all soNamKinhNghiems
  ///
  Future<void> all({
    required Function(List<SoNamKinhNghiemModel> soNamKinhNghiems) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => SoNamKinhNghiemModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert soNamKinhNghiem to database
  ///
  Future<void> add({
    required SoNamKinhNghiemModel data,
    required Function(SoNamKinhNghiemModel soNamKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SoNamKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update soNamKinhNghiem to database
  ///
  Future<void> update({
    required SoNamKinhNghiemModel data,
    required Function(SoNamKinhNghiemModel soNamKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SoNamKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete soNamKinhNghiem to database
  ///
  Future<void> delete({
    required String id,
    required SoNamKinhNghiemModel data,
    required Function(SoNamKinhNghiemModel soNamKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SoNamKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate soNamKinhNghiems "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<SoNamKinhNghiemModel> soNamKinhNghiems) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => SoNamKinhNghiemModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete soNamKinhNghiem to database
  ///
  Future<void> find({
    required String id,
    required Function(SoNamKinhNghiemModel soNamKinhNghiem) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SoNamKinhNghiemModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
