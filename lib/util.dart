import 'dart:convert';

import 'package:http/http.dart' as http;

final String _baseUrl = 'http://40.85.1 16.121:8202';

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

  var response = await http.post(url,
      body: {
        'UserName':username,
        'Password':password,
      }
  );

  return json.decode(response.body);
}

///Calls the register API.
Future<Map> register(String phone, String password) async {
  String url = '$_baseUrl/api/ApplicationUser/Register';

  var response = await http.post(url,
      body: {
        'Phone':phone,
        'Password':password,
      }
  );

  return json.decode(response.body);
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





