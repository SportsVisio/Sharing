import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';
import 'package:mvp/core/constants/api_endpoints.dart';
import 'package:mvp/network/api_exception.dart';
import 'package:mvp/network/api_response.dart';
import 'package:path/path.dart';

@lazySingleton
class ApiHelper {
  final String baseUrl = ApiEndPoints.BASE_URL;

  Dio _dio = Dio();

  ApiHelper() {
    _dio
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (kDebugMode) {
      var logInterceptor = LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        request: true,
        requestBody: true,
      );
      _dio.interceptors.add(logInterceptor);
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        baseUrl + uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      handleError(e);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        baseUrl + uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      handleError(e);
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.delete(
        baseUrl + uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      handleError(e);
    }
  }

  Future<dynamic> postMultiPart(
      String url, Map<String, dynamic> data, Map<String, File> files,
      {ProgressCallback? onSendProgress}) async {
    try {
      Map<String, MultipartFile> fileMap = {};
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = basename(file.path);
        fileMap[fileEntry.key] = MultipartFile(
          file.openRead(),
          await file.length(),
          filename: fileName,
        );
      }
      data.addAll(fileMap);
      var formData = FormData.fromMap(data);
      var response = await post(url,
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
          onSendProgress: onSendProgress);
      return response;
    } catch (e) {
      handleError(e);
    }
  }

  //handles Dio Error. that is not handled by the request and throws as Failure.
  Future handleError(e) {
    print('handleError: $e');
    if (e is DioError) {
      if (e.response == null) {
        throw FetchDataException({"message": "Please check your connectivity"});
      }
      switch (e.response!.statusCode) {
        case 400:
          throw BadRequestException();
        case 401:
        case 403:
          throw UnauthorisedException();
        case 404:
          throw NotFoundException(
              {"message": "Requested url is not available"});
        case 500:
        default:
          throw FetchDataException({
            "message":
                'Error occurred while Communication with Server with StatusCode : ${e.response!.statusCode}'
          });
      }
    }
    throw e;
  }

  ApiResponse parseJson<T extends Serializable>(json, {modelCreator}) {
    return ApiResponse<T>.fromJson(
      json,
      bodyParser: (body) {
        if (body is List) {
          return body.map<T>((element) => modelCreator(element)).toList();
        }
        return [modelCreator(body)].cast<T>();
      },
    );
  }

// Todo keeping for future reference
/* getLeagues() async {
    var json = await _apiService.get(ApiEndPoints.GET_LEAGUES);
    ApiResponse apiResponse =
        ApiResponse<LeaguesResponse>.fromJson(json, (data) {
      if (data is List) {
        List<LeaguesResponse> list = [];
        data.forEach((element) {
          list.add(LeaguesResponse.fromJson(element));
        });
        return list;
      }
      return [LeaguesResponse.fromJson(data)];
    });
    return apiResponse.body;
  }*/
}
