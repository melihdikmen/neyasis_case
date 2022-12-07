
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../base/base_model.dart';

class NetworkManager {
  static NetworkManager? _instance;

  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  Dio? _dio;

  NetworkManager._init() {
    final baseOptions =
        BaseOptions(baseUrl: "https://638e02774190defdb753a91e.mockapi.io");

    _dio = Dio(baseOptions);
  }

  setBaseApiUrl() {
    _dio!.options.baseUrl = "https://638e02774190defdb753a91e.mockapi.io";
  }

  Future<R?> dioPost<R, T extends BaseModel>(
      String path, T model, dynamic data) async {
    try {
      print(jsonEncode(data));
      final response = await _dio!.post(path, data: jsonEncode(data));
      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        final responseBody = response.data;
        if (kDebugMode) {
          print("HTTP RESPONSE: $path } \n $responseBody");
        }
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e) as T).toList() as R;
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody) as R;
        }
        return responseBody as R;
        }
       else {
        return null;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }

  Future<R?> dioGet<R, T extends BaseModel>(
    String path,
    T model,
  ) async {
    try {
      final response = await _dio!.get(path);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = response.data;
        if (kDebugMode) {
          print("response:$responseBody");
        }
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e) as T).toList() as R;
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody) as R;
        }
        return responseBody as R;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }


   Future<R?> dioDelete<R, T extends BaseModel>(
    String path,
    T model,
  ) async {
    try {
      final response = await _dio!.delete(path);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = response.data;
        if (kDebugMode) {
          print("response:$responseBody");
        }
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e) as T).toList() as R;
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody) as R;
        }
        return responseBody as R;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }


   Future<R?> dioPut<R, T extends BaseModel>(
    String path,
    T model,
    dynamic data
  ) async {
    try {
      final response = await _dio!.put(path,data: data);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = response.data;
        if (kDebugMode) {
          print("response:$responseBody");
        }
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e) as T).toList() as R;
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody) as R;
        }
        return responseBody as R;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }
}
