import 'dart:convert';

import 'package:banking_project/models/model.dart';
import 'package:http/http.dart';


class NoteServise{
  static bool isTester = true;
  static String SERVER_DEVELOPMENT = "6209f39992946600171c5636.mockapi.io";
  static String SERVER_PRODUCTION = "6209f39992946600171c5636.mockapi.io";

  static Map<String, String> getHeader(){
    Map<String,String> headers = {'Content-Type':"application/json; charset=UTF-8"};
    return headers;
  }
  static String getServer(){
    if(isTester)return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params);
    Response response = await get(uri, headers: getHeader());
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  static Future <String?> POST(String api, Map<String, String>params)async{
    var uri = Uri.https(getServer(), api);
    var response = await post(uri, headers: getHeader(),body: jsonEncode(params));
    print(response.body);

    if(response.statusCode == 200||response.statusCode == 201)
      return response.body;
    return null;
  }
  static Future <String?> PUT(String api, Map<String,String>params)async{
    var uri = Uri.https(getServer(), api);
    var response = await put(uri, headers: getHeader(),body: jsonEncode(params));
    print(response.body);
    if(response.statusCode == 200||response.statusCode == 201)
      return response.body;
    return null;
  }
  static Future<String?>PATCH(String api, Map<String, String >params)async{
    var uri = Uri.https(getServer(), api,params);
    var response = await delete(uri,headers: getHeader());
    print(response.body);
    if(response.statusCode == 200 )return response.body;
    return null;
  }
  /*Https Apis*/
  static String API_LIST = "/api/note";
  static String API_CREATE = "/api";
  static String API_UPDATE = '/api/';
  static String API_DELETE = '/api/';

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = new Map();
    return params;
  }
  static Map <String,String> paramsCreate(CardModel card){
    Map<String, String>params = new Map();
    params.addAll({
      'createdTime': card.createdTime.toString(),
      'cardNumber': card.cardNumber.toString(),
      "name":card.name.toString(),
      "sv":card.sv.toString(),
    } );
    return params;
  }
  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }
  // static Map <String,String> paramsUpdate(CardModel card){
  //   Map<String, String>params = new Map();
  //   params.addAll({
  //
  //     'CreatedTime': post.createdTime,
  //     'content': post.content,
  //   } );
  //   return params;
  // }
  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params);
    Response response = await delete(uri, headers: getHeader());
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  static List<CardModel> parsePostList(String response) {
    List list = jsonDecode(response);
    List<CardModel> photos = List<CardModel>.from(list.map((x) => CardModel.fromJson(x)));
    return photos;
  }
}