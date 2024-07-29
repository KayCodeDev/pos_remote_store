// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'dart:async';

import '../../utils/constant.dart';
import '../../utils/plugin/store_method.dart';

class Api {
  Dio dio = Dio(BaseOptions(
    baseUrl: "$kBaseEndpoint/api/v1/store/",
    receiveTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    responseType: ResponseType.json,
  ));

  Response<Map<String, dynamic>>? response;

  Future<Map<String, dynamic>> postData(Map<String, dynamic> data, url) async {
    if (await StoreMethod.isNetworkConnected()) {
      Map<String, dynamic> headers =
      await _getHeaders();
      try {
        response =
        await dio.post(url, data: data, options: Options(headers: headers));
        return _handleDioResponse(response);
      } on DioException catch (e) {
        return _handleDioResponse(e);
      }
    } else {
      return _noInternet();
    }
  }

  Future<Map<String, dynamic>> postFormData(FormData data, url) async {
    if (await StoreMethod.isNetworkConnected()) {
      Map<String, dynamic> headers =
      await _getHeaders();
      try {
        response =
        await dio.post(url, data: data, options: Options(headers: headers));
        return _handleDioResponse(response);
      } on DioException catch (e) {
        return _handleDioResponse(e);
      }
    } else {
      return _noInternet();
    }
  }

  Future<Map<String, dynamic>> getData(url) async {
    if (await StoreMethod.isNetworkConnected()) {
      Map<String, dynamic> headers =
      await _getHeaders();

      try {
        response = await dio.get(url, options: Options(headers: headers));
        return _handleDioResponse(response);
      } on DioException catch (e) {
        return _handleDioResponse(e);
      }
    } else {
      return _noInternet();
    }
  }

  _handleDioResponse(response) {
    // print(response);
    if (response is Response && response.statusCode == 200) {
      return response.data;
    } else {
      if (response is DioException && response.response is Response) {
        if (response.response!.data is String) {
          return {
            "status": "failed",
            "message": "Store is unavailable at the moment. Kindly try again",
          };
        }
        return response.response!.data;
      } else {
        return _noInternet();
      }
    }
  }

  _noInternet() {
    return {
      "status": "failed",
      "message": 'No internet connection. Connect and try again'
    };
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    String? serialNumber = await StoreMethod.getSerialNumber();
    Map<String, dynamic> _header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "x-api-key": kApiToken,
      "x-serial-number": serialNumber
    };

    return _header;
  }
}
