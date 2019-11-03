import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ticketawy/view/custom_widgets/CustomShowDialog.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import '../../globals.dart';
import '../../util.dart' as util;

//import '../../globals.dart';

class IdeasPage extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  IdeasPage({@required this.onPreviousPagePressed,
    @required this.onAllCategoriesPressed, @required this.onWillPop});


  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    if(Globals.pagesStack.top() != PagesIndices.ideasPageIndex)
      Globals.pagesStack.push(PagesIndices.ideasPageIndex);

    return WillPopScope(
      onWillPop: ()async{
        onWillPop();
        return false;
      },
      child: Scaffold(
//      resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              // The title
              Padding(
                padding: EdgeInsets.only(top: _width > 360?10:8.0, bottom: _width > 360?10:8.0),
                child: Text('Ideas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xfffe6700),
                      fontSize: 25,
                      fontFamily: 'Verdana'
                  ),
                ),
              ),
              IdeasForm(),


            ],
          ),
        ),

        // The footer buttons
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    onPreviousPagePressed();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Color(0xfffe6700),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/back.png', width: 30, height: 30,),
                        Text(
                          'Previous Page',
                          style: TextStyle(
                            color: Colors.white,fontFamily: 'MyriadPro',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onAllCategoriesPressed,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Color(0xff4b3d7a),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/all_events.png', width: 30, height: 30,),
                        Text(
                          'All Categories',
                          style: TextStyle(
                            color: Colors.white,fontFamily: 'MyriadPro',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IdeasForm extends StatefulWidget {
  @override
  _IdeasFormState createState() => _IdeasFormState();
}

class _IdeasFormState extends State<IdeasForm> {
  final TextEditingController _textEditingController = TextEditingController();

  File image;

  String _fileName = '';

  bool _sending = false;

  _showNoConnectivityDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 260.0,
              height: 230.0,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Text('Please check your internet connection and try again.',
                          style: TextStyle(
                            color: Color(0xfffe6700),
                            fontSize: 20,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      )
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text('Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _showResultDialog(BuildContext context, String message){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 260.0,
              height: 230.0,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Text('$message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xfffe6700),
                            fontSize: 20,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      )
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text('Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Center(

          // The title with the text area.
          child: Column(
            children: <Widget>[



              // Ideas text area
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50),
                child: Material(
                  elevation: 10.0, borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.black,
                  color: Colors.transparent,
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'Describe your idea here ...',

                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
              ),

              // Add photo
              _fileName.isEmpty?GestureDetector(
                onTap: () async{
                  try{
                    File _file = await FilePicker.getFile(
                        type: FileType.IMAGE, fileExtension: '');

                    image = _file;
//                  print('File Path: ${_file}');
//                  print('File name: ${basename(_file.path)}');
                    setState(() {
                      _fileName = basename(_file.path);
                    });
                  } catch (e){

                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 80, left: 50, top: 20, bottom: 10),
                    child: Image.asset('assets/add_photo.png',
                      height: Platform.isIOS?30
                          :_width> 360?42:28,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(right: 80, left: 50, top: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text(_fileName)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _fileName = '';
                          image = null;
                        });
                      },
                      child: Icon(Icons.clear, color: Colors.red,),
                    ),
                  ],
                ),
              ),

              // Send button
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: ListTile(
                  onTap: () async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    var connectivityResult = await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi){
                      _showNoConnectivityDialog(context);
                      return;
                    }
                    setState(() {
                      _sending = true;
                    });
                    var response = await util.addIdeas(message: _textEditingController.text, imageFile: image);

                    if(response != null){
                      _showResultDialog(context, response['user_Message']);
//                      print('$response');
                    } else {
                      _showResultDialog(context, 'Error while sending. Please try again');
                    }
                    setState(() {
                      _sending = false;
                      _fileName = '';
                    });
                    _textEditingController.value = _textEditingController.value.copyWith(text: '');
                  },
                  title: Material(
                    shadowColor: Colors.black,
                    elevation: 10,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('Send!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'MyriadPro'
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
        _sending?Positioned(
          left: 0.0, right: 0.0, top: 0.0, bottom: 0.0,
          child: Container(
            color: Colors.black.withOpacity(0.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(
                  itemBuilder: (context , int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffff6600),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ):
        Container(),
      ],
    );
  }
}


