import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

final String _baseUrl = 'http://40.85.116.121:8202';

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
  String url = '$_baseUrl/api/ApplicationUser/Login';

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
  String url = '$_baseUrl/api/ApplicationUser/Register';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  Map jsonMap = {
    'UserName':phone,
    'Password':password,
  };
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return json.decode(reply);
}

///Calls the event API specified by its id.
Future<List> getEventDetails(int id) async{
  String url = '$_baseUrl/api/Events/Events_Details?id=$id';

  var response = await http.get(url);

  return json.decode(response.body);
}

/// Calls the user details Api
Future<List> getUserDetails (String id) async{
  String url = '$_baseUrl/api/ApplicationUser/User_Details?id=$id';

  var response = await http.get(url);

  return json.decode(response.body);
}

/// Calls the user list Api
Future<List> getUserList () async {
  String url = '$_baseUrl/api/ApplicationUser/User_Details?id=null';

  http.Response response = await http.get(url);

  return jsonDecode(response.body);
}

/// Calls the VerificationMessage
Future<List> verification (String phone) async{
  String url = '$_baseUrl/api/ApplicationUser/Send_VerificationMessage';
  
  var response = await http.post(url,body: {

    'Phone' : phone
  });

  return jsonDecode(response.body);
}





