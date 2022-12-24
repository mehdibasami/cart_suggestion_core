import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'enum.dart';
import 'query_model.dart';
import 'response_model.dart';

class Api {
  Map<String, String> imageHeader = {
    //TODO
    HttpHeaders.authorizationHeader: "Bearer ${Constants.appToken}",

    "Accept": "multipart/byteranges",
    "content-type": "image/jpeg; charset=utf-8",
  };

  Map<String, String> bearerHeader = {
    HttpHeaders.authorizationHeader: "Bearer ${Constants.customerToken}",
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  }; //TODO

  Map<String, String> userBearerHeader = {
    HttpHeaders.authorizationHeader: "Bearer ${Constants.appToken}",
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };
  //TODO
  Map<String, String> creditBearerHeader = {
    HttpHeaders.authorizationHeader: "Bearer ${Constants.creditToken}",
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> formDataHeader = {
    "Accept": "multipart/form-data",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> basicHeader = {
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String>? headerGetter(HeaderEnum typeEnum) {
    switch (typeEnum) {
      case HeaderEnum.ImageHeaderEnum:
        return imageHeader;
      case HeaderEnum.BearerHeaderEnum:
        return bearerHeader;
      case HeaderEnum.UserBearerHeaderEnum:
        return userBearerHeader;
      case HeaderEnum.CreditBearerHeaderEnum:
        return creditBearerHeader;
      case HeaderEnum.FormDataHeaderEnum:
        return formDataHeader;
      case HeaderEnum.BasicHeaderEnum:
        return basicHeader;
      case HeaderEnum.EmptyHeaderEnum:
        return null;
      default:
        return basicHeader;
    }
  }

  String generateQuery(List<QueryModel> queries) {
    String query = "";
    if (queries.length > 0) {
      query += "?";
      queries.forEach((element) {
        if (element.value != null && element.value != "null") {
          String? nm = element.name;
          String? vl = element.value;

          query += "$nm=$vl&";
        }
      });
    }

    return query;
  }

  String urlGenerator(String url, List<QueryModel> query) {
    var queryPart = generateQuery(query);

    return "$url$queryPart";
  }

  String urlGenerator2(
      String url, List<QueryModel> query, String? pathVariable) {
    if (pathVariable != null) url += "/$pathVariable";
    var queryPart = generateQuery(query);

    return "$url$queryPart";
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    if (response.statusCode != 200) {
      printError('Url: ${response.request!.url.path}');
      printError('StatusCode: ${response.statusCode}');
    }
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);
          ResponseModel result = ResponseModel().fromJson(
            json.decode(data),
          );
          if (!result.isSuccess ||
              (result.statusCode != '200' && result.statusCode != 'success') ||
              result.data == null) {
            printError('Url: ${response.request!.url.path}');
            printError('StatusCode: ${result.statusCode}');
            printError('IsStatus: ${result.isSuccess}');
            printError('Data: ${result.data.toString()}');
            printError('Message: ${result.message}');
          }
          if (data.isEmpty) {
            printError('Url: ${response.request!.url.path}');
            printError('Data: $data');
            return ResponseModel(
                statusCode: "555",
                isSuccess: false,
                data: null,
                message: "مشکلی در ارتباط با سرور بوجود آمده است.");
          }

          return result;
        default:
          return response.bodyBytes;
      }
    } catch (e) {
      printError('Url: ${response.request!.url}');
      printError('StatusCode: ${response.statusCode}');
      printError('Error: ${e.toString()}');
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  static void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  responseDynamicGetter<T>(ResponseEnum typeEnum, Response<dynamic> response) {
    if (response.statusCode != 200) {
      printError('Url: ${response.realUri}');
      printError('StatusCode: ${response.statusCode}');
      printError('StatusMessage: ${response.statusMessage}');
      printError('Data: ${response.data.toString()}');
    }
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          ResponseModel result = ResponseModel().fromJson(response.data);
          if (!result.isSuccess ||
              (result.statusCode != '200' && result.statusCode != 'success') ||
              result.data == null) {
            printError('Url: ${response.realUri}');
            printError('StatusCode: ${result.statusCode}');
            printError('IsStatus: ${result.isSuccess}');
            printError('Data: ${result.data.toString()}');
            printError('Message: ${result.message}');
          }
          return result;
        default:
          return response.data.bodyBytes;
      }
    } catch (e) {
      printError('Url: ${response.realUri}');
      printError('StatusCode: ${response.statusCode}');
      printError('StatusMessage: ${response.statusMessage}');
      printError('Data: ${response.data.toString()}');
      printError('Error: ${e.toString()}');
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<bool> _checkStatus() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPGET<T>(
    String url,
    List<QueryModel> query,
    String? pathVariable,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    ResponseModel responseModel = ResponseModel();
    try {
      if (kDebugMode) {
        log(
          'GET: ${Uri.parse(urlGenerator2(url, query, pathVariable))}',
          name: 'CALL API',
        );
      }
      var response = await http.get(
        Uri.parse(urlGenerator2(url, query, pathVariable)),
        headers: headerGetter(headerType),
      );
      responseModel = responseGetter<T>(responseType, response);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPDELETE<T>(
    String url,
    List<QueryModel> query,
    String? pathVariable,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    ResponseModel responseModel = ResponseModel();

    try {
      var response = await http.delete(
        Uri.parse(urlGenerator2(url, query, pathVariable)),
        headers: headerGetter(headerType),
      );

      responseModel = responseGetter<T>(responseType, response);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPOST<T>(String url, List<QueryModel> query,
      var body, HeaderEnum headerType, ResponseEnum responseType) async {
    ResponseModel responseModel = ResponseModel();
    if (kDebugMode) {
      log(
        'POST: ${Uri.parse(urlGenerator(url, query))}',
        name: 'CALL API',
      );
      log(
        'body: $body',
        name: 'CALL API',
      );
    }
    try {
      var response = await http.post(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      responseModel = responseGetter<T>(responseType, response);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPUT<T>(
    String url,
    List<QueryModel> query,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    ResponseModel responseModel = ResponseModel();

    try {
      var response = await http.put(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      responseModel = responseGetter<T>(responseType, response);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPUTFILE<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    ResponseEnum responseType,
  ) async {
    ResponseModel responseModel = ResponseModel();

    try {
      Dio dio = Dio();

      var response = await dio.put(
        urlGenerator(url, query),
        data: body,
      );
      responseModel = responseGetter<T>(responseType, response.data);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPOSTFORM<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    ResponseModel responseModel = ResponseModel();

    try {
      Dio dio = Dio();

      var response = await dio.post(urlGenerator(url, query),
          data: body,
          options: Options(
            headers: headerGetter(headerType),
          ));

      responseModel = responseDynamicGetter<T>(responseType, response);
    } catch (e) {
      printError('Url: $url');
      printError(e.toString());
      await _checkStatus().then((value) {
        if (value) {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "500",
              data: null,
              message: "خطایی در عملیات رخ داده است");
        } else {
          responseModel = ResponseModel(
              isSuccess: false,
              statusCode: "510",
              data: null,
              message: "لطفا اتصال به اینترنت را بررسی کنید.");
        }
      });
    }
    return responseModel;
  }
  //TODO

  static getToken() {
    // if (UserServiceV2.customerjwt != null)
    //   return UserServiceV2.customerjwt?.accessToken ?? '';
    // else
    //   return UserServiceV2.jwt?.accessToken ?? '';
  }
}
