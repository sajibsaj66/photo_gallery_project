import 'package:dio/dio.dart';

import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

const String baseUrl = "https://dummyjson.com/products";

final options = BaseOptions(
    baseUrl: baseUrl, headers: {'Content-Type': 'application/json'});

final options1 = BaseOptions(
    baseUrl: baseUrl, headers: {'Content-Type': 'application/json'});

class GetDio {
  static Dio getDio() {
    Dio dio = Dio(options);
/*    dio.interceptors.add(RetryInterceptor(
        dio: dio,
        logPrint: print, // specify log function (optional)
        retries: 3, // retry count (optional)
        retryDelays: const [ // set delays between retries (optional)
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
        ignoreRetryEvaluatorExceptions: true,
        retryableExtraStatuses: {404}
    ));*/
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
    return dio;
  }
}

/*void updateCookie(Dio dio, Response response) {
    List<String>? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      dio.options.headers['cookie'] = rawCookie.first;
    }
 }*/
