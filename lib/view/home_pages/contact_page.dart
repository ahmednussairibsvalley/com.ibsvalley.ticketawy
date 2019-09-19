import 'package:flutter/material.dart';

import '../../globals.dart';


class ContactPage extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;

  ContactPage({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    Globals.pagesStack.push(PagesIndices.contactPageIndex);

    return Scaffold(
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
                        'All Events',
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
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Center(

      // The title with the text area.
      child: Column(
        children: <Widget>[



          // Subject text field
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.black,
              color: Colors.transparent,
              child: TextField(
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
              child: TextField(
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
              ),
            ),
          ),

          // Add photo
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: 80, left: 50, top: 20, bottom: 10),
              child: Image.asset('assets/add_photo.png', width: _width > 360 ?163:110, height: _width> 360?42:28,alignment: Alignment.centerLeft,),
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

