import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';


import '../base/base_model.dart';

class NetworkManager {
  static NetworkManager? _instance;

  static NetworkManager? get instance {
    if (_instance == null) _instance = NetworkManager._init();
    return _instance;
  }

  Dio? _dio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: "");

    _dio = Dio(baseOptions);
  }

 
  setBaseApiUrl() {
    _dio!.options.baseUrl = "";
  }

  Future<R?> dioPost<R, T extends BaseModel>(String path, T model, dynamic data) async {
    try {
      final response = await _dio!.post(path, data: data);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = response.data;
        print("HTTP RESPONSE: $path } \n $responseBody");
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
      print(e.message);
      return null;
    }
  }

  Future<R?> dioGet<R, T extends BaseModel>(
    String path,
    T model,
  ) async {
    try {
      final response = await Dio().get(path);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = response.data;
        print("response:$responseBody");
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e)).toList() as R;
        } else if (responseBody is Map<String, dynamic>) return model.fromJson(responseBody) as R;
        return responseBody as R;
      } else
        return null;
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }

}