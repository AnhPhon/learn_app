import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/image_model.dart';

class ImageUpdateRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ImageUpdateRepository();

  ///
  /// Get all uploads
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/uploads');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> add(File file) async {
    try {
      final response = await dioClient!.uploadImage('/uploads', file: file);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> addFile(PlatformFile file) async {
    try {
      final response = await dioClient!.uploadFile('/uploads', file: file);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> addImages(List<File> files) async {
    try {
      final response = await dioClient!.uploadImages('/uploads', files: files);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> addFiles(List<PlatformFile> files) async {
    try {
      final response = await dioClient!.uploadFiles('/uploads', files: files);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update import-ware-house to database
  ///
  Future<ApiResponse> update(ImageUpdateModel data) async {
    try {
      final response = await dioClient!.put('/uploads', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update import-ware-house to database
  ///
  Future<ApiResponse> delete(String id, ImageUpdateModel data) async {
    try {
      final response =
          await dioClient!.delete('/uploads/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate uploads "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/uploads/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/uploads/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find import-ware-house by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/uploads/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
