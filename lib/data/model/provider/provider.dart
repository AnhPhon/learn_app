// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/danh_muc_san_pham/product_portfolio_request.dart';
import 'package:template/data/model/danh_muc_san_pham/product_portfolio_response.dart';
import 'package:template/data/model/san_pham/product_request.dart';
import 'package:template/data/model/san_pham/product_response.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';

enum IZIMethod {
  GET,
  ADD,
  UPDATE,
  DELETE,
  PAGINATE,
  FIND,
}

class Provider<T> {
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  
  dynamic getModel(T typeModel) {
    if (typeModel is UserResponse) {
      return UserResponse;
    }else if (typeModel is UserRequest) {
      return AuthRequest;
    } else if (typeModel is AuthResponse) {
      return AuthResponse;
    }else if (typeModel is AuthRequest) {
      return AuthRequest;
    }else if (typeModel is ProductPortfolioRequest) {
      return ProductPortfolioRequest;
    }else if (typeModel is ProductRequest) {
      return ProductRequest;
    }else if (typeModel is ProductResponse) {
      return ProductResponse;
    }
    return T;
  }

  String getEndPoint(T typeModel) {
    if (typeModel is UserResponse || typeModel is AuthRequest) {
      return 'user';
    } else if (typeModel is AuthResponse || typeModel is AuthRequest) {
      return 'login';
    }else if (typeModel is AuthResponse || typeModel is AuthRequest) {
      return 'san_phams';
    }else if (typeModel is ProductPortfolioRequest || typeModel is ProductPortfolioResponse) {
      return 'danh_muc_san_pham';
    }else if (typeModel is ProductResponse || typeModel is ProductRequest) {
      return 'danh_muc_san_pham';
    }
    return '';
  }

  Future<void> call({
    required IZIMethod method,
    required String endPoint,
    required T typeModel,
    int? page = 1,
    int? limit = 10,
    String? filter = '',
    String? id = '',
    T? data,
    required Function(List<T> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: method,
      endPoint: endPoint,
      page: page,
      limit: limit,
      filter: filter,
      id: id,
      data: data,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => getModel(typeModel).fromJson(e as Map<String, dynamic>)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }


  ///
  /// Get all data
  ///
  Future<void> all(T typeModel,{
    required Function(List<T> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.GET,
      endPoint: getEndPoint(typeModel) //getModel(typeModel).endPoint.toString(),
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => getModel(typeModel).fromJson(e as Map<String, dynamic>)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert 
  ///
  Future<void> add(T typeModel,{
    required T requestBody,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.GET,
      endPoint: getEndPoint(typeModel),
      data: requestBody,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel).fromJson(results as Map<String, dynamic>) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update 
  ///
  Future<void> update(T typeModel,{
    required T requestBody,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.UPDATE,
      endPoint: getEndPoint(typeModel),
      data: requestBody,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel).fromJson(results as Map<String, dynamic>) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete 
  ///
  Future<void> delete(T typeModel,{
    required String id,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.DELETE,
      endPoint: getEndPoint(typeModel),
      id: id,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel).fromJson(results as Map<String, dynamic>) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate 
  ///
  Future<void> paginate(T typeModel,{
    required int page,
    required int limit,
    required String filter,
    required Function(List<T> bangGiaDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.PAGINATE,
      endPoint: getEndPoint(typeModel),
      page: page,
      limit: limit,
      filter: filter,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['results'] as List<dynamic> : [];
      onSuccess(results.map((e) => getModel(typeModel).fromJson(e as Map<String, dynamic>)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Find one by id
  ///
  Future<void> findOne(T typeModel,{
    required String id,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.FIND,
      endPoint: getEndPoint(typeModel),
      id: id,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel).fromJson(results as Map<String, dynamic>) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  Future<ApiResponse> getReponstory({
    required IZIMethod method,
    required String endPoint,
    dynamic data,
    int? page,
    int? limit,
    String? filter,
    String? id,
  }) async {
    Response<dynamic>? response;
    String url = '${BASE_URL}/${endPoint}';
    if (method == IZIMethod.PAGINATE) {
      if (filter!.isEmpty) {
        url += 'paginate?page=$page&limit=$limit';
      } else {
        url += 'paginate?page=$page&limit=$limit$filter';
      }
    } else if (method == IZIMethod.DELETE || method == IZIMethod.FIND) {
      if (id!.isNotEmpty) {
        url += '/$id';
      }
    }
    try {
      if (method == IZIMethod.GET) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      } else if (method == IZIMethod.ADD) {
        if (!IZIValidate.nullOrEmpty(dioClient) && !IZIValidate.nullOrEmpty(data)) {
          response = await dioClient!.post(url, data: data!.toJson());
        }
      } else if (method == IZIMethod.UPDATE) {
        if (!IZIValidate.nullOrEmpty(dioClient) && !IZIValidate.nullOrEmpty(data)) {
          response = await dioClient!.put(url, data: data.toJson());
        }
      } else if (method == IZIMethod.DELETE) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.delete(url);
        }
      } else if (method == IZIMethod.PAGINATE) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      } else if (method == IZIMethod.FIND) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      }

      if (!IZIValidate.nullOrEmpty(response)) {
        return ApiResponse.withSuccess(response!);
      }

      return ApiResponse.withError("No value");
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
