import 'package:flutter/material.dart';
import 'package:breakingbad/constans/strings.dart';
import 'package:dio/dio.dart';
import 'package:breakingbad/data/model/Character.dart';
class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<Character>> getAllCharacters()async{
    try{
      Response response = await dio.get('characters');
    print(response.data.toString());
    return response.data;}

        catch (e){
      print(e.toString());
      return [];
        }
  }
}
