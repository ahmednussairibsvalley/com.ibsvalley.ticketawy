import 'package:flutter/material.dart';

import '../../globals.dart';

class IdeasPage extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;

  IdeasPage({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed});
  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.ideasPageIndex);
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
              child: Text('Ideas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfffe6700),
                  fontSize: 25,
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
              child: GestureDetector(
                onTap: onAllCategoriesPressed,
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.purple,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset('assets/all_events.png', width: 30, height: 30,),
                      Text(
                        'All Categories',
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
          ],
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
                  labelText: 'Describe your idea here ...',

                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: ListTile(
              title: Material(
                shadowColor: Colors.black,
                elevation: 10,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text('Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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

