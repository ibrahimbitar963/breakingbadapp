import 'dart:ffi';

import 'package:breakingbad/constans/strings.dart';
import 'package:dio/dio.dart';

class QuoteWebService {
  late Dio dio;

  QuoteWebService() {
    BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
  }

  Future<List<dynamic>> getQuote(String charName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': charName});
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
