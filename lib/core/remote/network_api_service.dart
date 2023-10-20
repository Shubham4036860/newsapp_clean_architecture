import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:news_app/core/remote/network_base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/remote/news_app_exception.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getAllNewsResponse(String url, String countryCode, String newsType) async {
    dynamic responseJson;
    try {
      if (newsType.isEmpty) {
        var query = {"apiKey": newsAPIKey, "country": countryCode};
        var uri = Uri.http(newsAPIBaseURL, url, query);
        if (kDebugMode) {
          print(uri.toString());
          print(uri.queryParametersAll.toString());
        }
        final response = await http.get(uri);
        responseJson = returnResponse(response);
        print("object=======>$responseJson");
      } else {
        var query = {"apiKey": newsAPIKey, "country": countryCode, "category": newsType};
        var uri = Uri.http(newsAPIBaseURL, url, query);
        if (kDebugMode) {
          print(uri.toString());
          print(uri.queryParametersAll.toString());
        }
        final response = await http.get(uri);
        responseJson = returnResponse(response);
      }
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
