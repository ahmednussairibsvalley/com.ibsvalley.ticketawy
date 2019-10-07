import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ticketawy/globals.dart';

final String _baseUrl = 'http://40.85.116.121:8607';

/// Is the image URL available
Future<bool> isImageUrlAvailable(String imageUrl) async{
  var response = await http.get(imageUrl);
  if(response.statusCode == 200){
    return true;
  }
  return false;
}


///Calls the login API.
Future<Map> login(String username, String password) async {
  String url = '$_baseUrl/api/AspNetUsers/Login';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'UserName':username,
    'Password':password,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);

}

///Calls the register API.
Future<Map> register(String phone, String password) async {

  /*
  Failure Response:
  {
      "succeeded": false,
      "errors": [
          {
              "code": "DuplicateUserName",
              "description": "User name '01157426778' is already taken."
          }
      ]
  }
  Success Response:
  {
      "succeeded": true,
      "errors": []
  }
   */
  String url = '$_baseUrl/api/AspNetUsers/Register';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone':phone,
    'Password':password,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

///Calls the event API specified by its id.
Future<Map> getEventDetails(int id) async{
  String url = '$_baseUrl/api/Event/Events_Details?id=$id';

  var response = await http.get(url);

  List result = json.decode(response.body);
  return result[0];
}

/// Calls the user details Api
Future<Map> getUserDetails () async{
  String url = '$_baseUrl/api/AspNetUsers/User_Details?id=${Globals.userId}';

  var response = await http.get(url);

//  print('${jsonDecode(response.body)}');
  return jsonDecode(response.body);
}

/// Calls the user list Api
Future<List> getUserList () async {
  String url = '$_baseUrl/api/ApplicationUser/User_Details?id=null';

  http.Response response = await http.get(url);

  return jsonDecode(response.body);
}

/// Calls the VerificationMessage
Future<Map> sendVerificationMessage (String phone) async{
  String url = '$_baseUrl/api/AspNetUsers/Send_VerificationMessage';
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone' : phone
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<Map> verifyPhone (String phone, String code) async {
  String url = '$_baseUrl/api/AspNetUsers/Verify_Phone';
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone' : phone,
    'Code' : code,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

/// Calling the Category List
Future<List> categoryList () async{
  String url = '$_baseUrl/api/Event/Category_list';

  var response = await http.get(url);

  return jsonDecode(response.body);
}

Future<Map> getHomeLists() async {
  String url = '$_baseUrl/api/Home/Home_Lists';

  var response = await http.get(url);

  return jsonDecode(response.body);
}

Future<List> getHomeEvents() async {
  String url = '$_baseUrl/api/Home/Home_Lists';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result['homeEvents'];
}

Future<List> getHotEvents() async {
  String url = '$_baseUrl/api/Home/Home_Lists';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result['hotEvents'];
}

Future<List> getServiceClasses(int id) async{
  String url = '$_baseUrl/api/Order/Service_Class?id=$id';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result;
}

Future<List> getEventsList(int categoryId) async{
  String url = '$_baseUrl/api/Event/Events_List?id=$categoryId';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result;
}

Future<Map> updateUserDetails({@required String fullName,
  @required String phoneNumber,@required String password}) async {
  String url = '$_baseUrl/api/AspNetUsers/Update_User';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'fullName':fullName,
    'PhoneNumber':phoneNumber,
    'Password':password,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<Map> addToRemoveFromWishList(int eventId) async {
  String url = '$_baseUrl/api/Event/Add_Wishlist?Event_Id=$eventId&User_Id=${Globals.userId}';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {};
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<List> getWishList () async {
  String url = '$_baseUrl/api/Event/Get_Wishlist?User_Id=${Globals.userId}';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result;
}