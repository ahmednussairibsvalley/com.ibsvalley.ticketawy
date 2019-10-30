import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ticketawy/globals.dart';

final String _baseUrl = 'http://40.85.116.121:8607';


/// Time-out in seconds
final int timeOut = 60;

/// Is the image URL available
Future<bool> isImageUrlAvailable(String imageUrl) async{
  try{
    var response = await http.get(imageUrl).timeout(Duration(seconds: timeOut));

    if(response.statusCode == 200){
      return true;
    }
    return false;
  } on TimeoutException catch(_){
    return false;
  } catch (e){
    return null;
  }
}


///Calls the login API.
Future<Map> login(String username, String password) async {
  try{
    String url = '$_baseUrl/api/AspNetUsers/Login';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'UserName':username,
      'Password':password,
    };
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }

}

///Calls the register API.
Future<Map> register(String fullName, String phone, String password) async {

  try{
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
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

///Calls the event API specified by its id.
Future<Map> getEventDetails(int id) async{
  try{
    String url = '$_baseUrl/api/Event/Events_Details?id=$id';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    List result = json.decode(response.body);
    return result[0];
  } on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

/// Calls the user details Api
Future<Map> getUserDetails () async{
  try{
    String url = '$_baseUrl/api/AspNetUsers/User_Details?id=${Globals.userId}';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));
    return jsonDecode(response.body);
  } on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

/// Calls the user list Api
Future<List> getUserList () async {
  try{
    String url = '$_baseUrl/api/ApplicationUser/User_Details?id=null';

    http.Response response = await http.get(url).timeout(Duration(seconds: 2));

    return jsonDecode(response.body);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

/// Calls the VerificationMessage
Future<Map> sendVerificationMessage (String phone) async{
  try{
    String url = '$_baseUrl/api/AspNetUsers/Send_VerificationMessage';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Phone' : phone
    };
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }

}

Future<Map> verifyPhone (String phone, String code) async {
  try{
    String url = '$_baseUrl/api/AspNetUsers/Verify_Phone';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Phone' : phone,
      'Code' : code,
    };
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

/// Calling the Category List
Future<List> categoryList () async{
  try{
    String url = '$_baseUrl/api/Event/Category_list';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    return jsonDecode(response.body);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> getHomeLists() async {
  try{
    String url = '$_baseUrl/api/Home/Home_Lists';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    return jsonDecode(response.body);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getHomeEvents() async {
  try{
    String url = '$_baseUrl/api/Home/Home_Lists';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result['homeEvents'];
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getHotEvents() async {
  try{
    String url = '$_baseUrl/api/Home/Home_Lists';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result['hotEvents'];
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getServiceClasses(int id) async{
  try{
    String url = '$_baseUrl/api/Order/Service_Class?id=$id';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getEventsList(int categoryId) async{
  try{
    String url = '$_baseUrl/api/Event/Events_List?categoryId=$categoryId';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> updateUserDetails({@required String fullName,
  @required String phoneNumber,@required String password}) async {
  try{
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
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> addToRemoveFromWishList(int eventId) async {
  try{
    String url = '$_baseUrl/api/Event/Add_Wishlist?Event_Id=$eventId&User_Id=${Globals.userId}';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {};
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getWishList () async {

  try{
    String url = '$_baseUrl/api/Event/Get_Wishlist?User_Id=${Globals.userId}';

    var response = await http.get(url);

    var result = jsonDecode(response.body);
    return result;
  } catch (e){
    return null;
  }
}


/// Search
Future<List> search(String keyWord) async {
  try{
    String url = '$_baseUrl/api/Search/Search_Result?searchword=$keyWord';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  } on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<List> getOrdersHistory() async {
  try{
    String url = '$_baseUrl/api/Order/Order_History?id=${Globals.userId}';
    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  }on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> contactUs({@required String phoneEmail, @required String subject,
  @required String message}) async{

  try{
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
  }on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> addOrder({@required int eventId, @required List orders}) async {
  try{
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

    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> recoverPassword(String phoneNumber) async{
  try{
    String url = '$_baseUrl/api/AspNetUsers/ForgotPassword';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Phone':'$phoneNumber',
    };
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  } on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> addIdeas({File imageFile, @required String message}) async {

  try{
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

      String reply = await response.stream.transform(utf8.decoder).join();

      return json.decode(reply);
    }
  } catch (e){
    print(e.toString());
    return null;
  }



}

Future<Map> updatePassword({@required String phoneNumber, @required String newPassword}) async{
  try{
    String url = '$_baseUrl/api/AspNetUsers/UpdatePassword';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Phone':'$phoneNumber',
      'Password':'$newPassword',
    };
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> availableTickets({@required int quantity,
  @required int classId,
  @required int activityServiceId}) async{
  try{
    String url = '$_baseUrl/api/Order/Available_Tickets?'
        'Ticket_num=$quantity&Activity_service_Id=$activityServiceId'
        '&class_id=$classId';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  }on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> confirmPasswordCode({@required String phoneNumber, @required String code}) async{
  try{
    String url = '$_baseUrl/api/AspNetUsers/Confirm_Password_Code';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Phone':'$phoneNumber',
      'Code':'$code',
    };
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}

//Future<String> get _localPath async {
//  final directory = await getApplicationDocumentsDirectory();
//
//  return directory.path;
//}

//Future<File> get _localFile async {
//  final path = await _localPath;
//  return File('$path/msg.txt');
//}
//
//Future<File> writeContent(String msg) async {
//  final file = await _localFile;
//
//  // Write the file.
//  return file.writeAsString('$msg');
//}
//
//Future<String> readContent() async {
//  try {
//    final file = await _localFile;
//
//    // Read the file.
//    String contents = await file.readAsString();
//
//    return contents;
//  } catch (e) {
//    // If encountering an error, return 0.
//    return null;
//  }
//}

Future<List> getTicketDetails(String orderId) async{
  try{
    String url = '$_baseUrl/api/Tickets/Ticket_details?orderId=$orderId';

    var response = await http.get(url).timeout(Duration(seconds: timeOut));

    var result = jsonDecode(response.body);
    return result;
  }on TimeoutException catch (_){
    return null;
  } catch (e){
    return null;
  }
}

Future<Map> onPaymentSuccessful({
    @required bool paymentResult,
    @required String transactionId,
    @required String paymentType,
    @required String refNumber,}) async{

  try{
    String url = '$_baseUrl/api/Order/payment_successful';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      'Paymentresult':'$paymentResult',
      'transaction_Id':'$transactionId',
      'payment_type':paymentType,
      'fawryRefNumber':refNumber,
    };
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close().timeout(Duration(seconds: timeOut));
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }on TimeoutException catch(_){
    return null;
  } catch (e){
    return null;
  }
}