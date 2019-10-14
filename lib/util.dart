import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
Future<Map> register(String fullName, String phone, String password) async {

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
    'fullName':fullName,
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
  String url = '$_baseUrl/api/Event/Events_List?categoryId=$categoryId';

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

  try{
    String url = '$_baseUrl/api/Event/Get_Wishlist?User_Id=${Globals.userId}';

    var response = await http.get(url);

    var result = jsonDecode(response.body);
    return result;
  }catch (e){
    return null;
  }
}


/// Search
Future<List> search(String keyWord) async {
  String url = '$_baseUrl/api/Search/Search_Result?searchword=$keyWord';

  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result;
}

Future<List> getOrdersHistory() async {
  //String url = '$_baseUrl/api/Order/Order_History?id=e00a11e5-2c02-4ac9-b5db-c24ff9cbbb92';
  String url = '$_baseUrl/api/Order/Order_History?id=${Globals.userId}';
  var response = await http.get(url);

  var result = jsonDecode(response.body);
  return result;
}

Future<Map> contactUs({@required String phoneEmail, @required String subject,
  @required String message}) async{

  String url = '$_baseUrl/api/AspNetUsers/Contact_Us';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone_Email':phoneEmail,
    'Subject':subject,
    'Message':message,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<Map> addOrder({@required int eventId, @required List orders}) async {
  String url = '$_baseUrl/api/Order/payment';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'EventId':'$eventId',
    'userId':Globals.userId,
    'Order_Tickets':orders,
  };
  request.add(utf8.encode(json.encode(jsonMap)));

  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<Map> recoverPassword(String phoneNumber) async{
  String url = '$_baseUrl/api/AspNetUsers/Send_VerificationMessage';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone':'$phoneNumber',
  };
  request.add(utf8.encode(json.encode(jsonMap)));

  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

Future<Map> addIdeas({File imageFile, @required String message}) async {

  // string to uri
  var uri = Uri.parse('$_baseUrl/api/AspNetUsers/User_Ideas');

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  if(imageFile != null){
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields.addAll({
      'message':message
    });

    // send
    var response = await request.send();
    print(response.statusCode);

//  // listen for response
//  response.stream.transform(utf8.decoder).listen((value) {
//    print(value);
//  });

    String reply = await response.stream.transform(utf8.decoder).join();

    return json.decode(reply);
  }
  else {
    request.fields.addAll({
      'message':message,
      'image':'null',
    });

    // send
    var response = await request.send();
    print(response.statusCode);

//  // listen for response
//  response.stream.transform(utf8.decoder).listen((value) {
//    print(value);
//  });

    String reply = await response.stream.transform(utf8.decoder).join();

    return json.decode(reply);
  }


}

Future<Map> updatePassword({@required String phoneNumber, @required String code, @required String newPassword}) async{
  String url = '$_baseUrl/api/AspNetUsers/UpdatePassword';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'Phone':'$phoneNumber',
    'Code':'$code',
    'Password':'$newPassword',
  };
  request.add(utf8.encode(json.encode(jsonMap)));

  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}