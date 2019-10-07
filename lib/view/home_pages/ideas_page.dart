import 'dart:io';

import 'package:flutter/material.dart';

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
//    Globals.pagesStack.push(PagesIndices.ideasPageIndex);

    return WillPopScope(
      onWillPop: () async{
        onWillPop();
        return null;
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

class IdeasForm extends StatefulWidget {
  @override
  _IdeasFormState createState() => _IdeasFormState();
}

class _IdeasFormState extends State<IdeasForm> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    return Center(

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
          Container(
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

          // Send button
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ListTile(
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
    );
  }
}

