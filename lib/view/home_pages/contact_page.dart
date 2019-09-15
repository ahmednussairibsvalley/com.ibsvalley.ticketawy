import 'package:flutter/material.dart';

import '../../globals.dart';


class ContactPage extends StatelessWidget {

  final Function onPreviousPagePressed;

  ContactPage({@required this.onPreviousPagePressed});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(8.0),
              child: Text('Contact Us',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfffe6700),
                  fontSize: 25,
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
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/all_events.png', width: 30, height: 30,),
                    Text(
                      'All Events',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
    return Center(

      // The title with the text area.
      child: Column(
        children: <Widget>[



          // Subject text field
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.black,
              color: Colors.transparent,
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Message text area
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.black,
              color: Colors.transparent,
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Your message here ...',

                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),

          // Add photo
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20, bottom: 10),
            child: Image.asset('assets/add_photo.png', width: 163, height: 42,alignment: Alignment.centerLeft,),
          ),

          // Send button
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ListTile(
              title: Container(
                padding: EdgeInsets.all(20),
                child: Text('Send',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    color: Color(0xfffe6700),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

