import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/image_model.dart';
import 'package:template/data/repository/image_repository.dart';

class ImageUpdateProvider {
  ImageUpdateRepository? regionRepo = GetIt.I.get<ImageUpdateRepository>();

  ImageUpdateProvider();

  ///
  /// Get all uploadImages
  ///
  Future<void> all({
    required Function(List<ImageUpdateModel> uploadImages) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => ImageUpdateModel.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert uploadImage to database
  ///
  Future<void> add({
    required File file,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(file);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert uploadImage to database
  ///
  Future<void> addFile({
    required PlatformFile file,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.addFile(file);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert uploadImage to database
  ///
  Future<void> addImages({
    required List<File> files,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    int countSize = 0;
    const int maxMBFilesSize = 20;

    for (var i = 0; i < files.length; i++) {
      countSize += await files[i].length();
    }
    if (countSize > maxMBFilesSize * 1024 * 1024) {
      return onError( Exception('Dung lượng ảnh không quá $maxMBFilesSize MB, vui lòng chọn file khác'));
    }

    final ApiResponse apiResponse = await regionRepo!.addImages(files);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert uploadImage to database
  ///
  Future<void> addFiles({
    required List<PlatformFile> files,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    int countSize = 0;
    const int maxMBFilesSize = 50;

    for (var i = 0; i < files.length; i++) {
      countSize += files[i].size;
    }
    if (countSize > maxMBFilesSize * 1024 * 1024) {
      return onError( Exception('Dung lượng file không quá $maxMBFilesSize MB, vui lòng chọn file khác'));
    }

    final ApiResponse apiResponse = await regionRepo!.addFiles(files);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update uploadImage to database
  ///
  Future<void> update({
    required ImageUpdateModel data,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete uploadImage to database
  ///
  Future<void> delete({
    required String id,
    required ImageUpdateModel data,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate uploadImages "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ImageUpdateModel> uploadImages) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['results'] as List<dynamic> : [];
      onSuccess(results.map((e) => ImageUpdateModel.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete uploadImage to database
  ///
  Future<void> find({
    required String id,
    required Function(ImageUpdateModel uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ImageUpdateModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
