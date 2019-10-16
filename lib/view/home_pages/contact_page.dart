//import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ticketawy/view/custom_widgets/CustomShowDialog.dart';

import '../../globals.dart';
import '../../util.dart' as util;

//import '../../globals.dart';


class ContactPage extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  ContactPage({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed,
  @required this.onWillPop});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    Globals.pagesStack.push(PagesIndices.contactPageIndex);

    return WillPopScope(
      onWillPop: () async{
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
                child: Text('Contact Us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xfffe6600),
                      fontSize: 25,
                      fontFamily: 'Verdana'
                  ),
                ),
              ),
              ContactForm(),




            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: onPreviousPagePressed,
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

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mailPhoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _sending = false;


  _showNoConnectivityDialog(){
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

  @override
  Widget build(BuildContext context) {
//    final _width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Center(

          // The title with the text area.
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  children: <Widget>[
                    //Email or Phone
                    Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
                      child: Material(
                        elevation: 10.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _mailPhoneController,
                          decoration: InputDecoration(
                            hintText: 'Email or phone number',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none
                            ),
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your phone or email.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // Subject text field
                    Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
                      child: Material(
                        elevation: 10.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        child: TextFormField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            hintText: 'Subject',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Message text area
                    Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40),
                      child: Material(
                        elevation: 10.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        child: TextFormField(
                          controller: _messageController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Your message here ...',

                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none
                            ),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return 'Please enter your message';
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                key: _formKey,
              ),

//          // Add photo
//          Container(
//            alignment: Alignment.centerLeft,
//            child: Padding(
//              padding: const EdgeInsets.only(right: 80, left: 50, top: 20, bottom: 10),
//              child: Image.asset('assets/add_photo.png',
//                height: Platform.isIOS?30
//                    :_width> 360?42:28,
//                alignment: Alignment.centerLeft,
//              ),
//            ),
//          ),

              // Send button
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
                child: ListTile(
                  onTap: () async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    var connectivityResult = await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi){
                      _showNoConnectivityDialog();
                      return;
                    }
                    if(_formKey.currentState.validate()){
                      setState(() {
                        _sending = true;
                      });

                      Map response = await util.contactUs(phoneEmail: _mailPhoneController.text,
                          subject: _subjectController.text,
                          message: _messageController.text);


                      setState(() {
                        _sending = false;
                      });

                      _mailPhoneController.value = _mailPhoneController.value.copyWith(text: '');
                      _subjectController.value = _subjectController.value.copyWith(text: '');
                      _messageController.value = _messageController.value.copyWith(text: '');
                      _showSuccessDialog(context, response);
                    }


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
        _sending? Positioned(
          top: 0.0, bottom: 0.0, left: 0.0, right: 0.0,
          child: Container(
            color: Colors.black.withOpacity(0.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
        ):
        Container(),
      ],
    );
  }
}

_showSuccessDialog(BuildContext context, Map data) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: Container(
            width: 300.0,
            height: 200.0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    data['user_Message'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 17,
                    ),
                  ),
                ),
                ListTile(
                  onTap: ()async {
                    Navigator.of(context).pop();
                  },
                  title: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffe6700),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

