import 'package:flutter/material.dart';

import '../../globals.dart';

class BuyTickets extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;

  BuyTickets({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed});
  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.buyTicketsPageIndex);

    return WillPopScope(
      onWillPop: () async{
        onPreviousPagePressed();
        return true;
      },
      child: Scaffold(
        body: buyTickets(),
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
                    color: Color(0xff4b3d7a),
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
      ),
    );
  }
}


class buyTickets extends StatefulWidget {
  @override
  _buyTicketsState createState() => _buyTicketsState();
}

class _buyTicketsState extends State<buyTickets> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Event name here',
                  style: TextStyle(color: Color(0xff6f7c7d), fontSize: 20),
                ),
                Text(
                  'Seats order information',
                  style: TextStyle(color: Color(0xffff8020), fontSize: 20),
                ),
                SizedBox(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.black38,
                          width: 2,
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5, right: 5, top: 5, left: 5),
                              child: Text('Section',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5, right: 5, top: 5, left: 5),
                              child: Text('Row',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5, right: 5, top: 5, left: 5),
                              child: Text('Seats',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 20)),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'C16-RIGHT',
                                style: TextStyle(
                                    color: Color(0xff592c82), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                '5',
                                style: TextStyle(
                                    color: Color(0xff592c82), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                '10-12',
                                style: TextStyle(
                                    color: Color(0xff592c82), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Tickets number',
                style: TextStyle(color: Color(0xff592c82), fontSize: 20),
              ),
              Text(
                'Tickets number',
                style: TextStyle(color: Color(0xff592c82), fontSize: 20),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 35,
                child: FlatButton(
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {},
                  color: Color(0xff592c82),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                width: 100,
                height: 35,
                child: FlatButton(
                  child: Text(
                    "100\$",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {},
                  color: Color(0xff592c82),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Container(
                width: 200,
                height: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Card(
                  color: Colors.white70,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. cumsan lacus vel facilisis. ",
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                        softWrap: true,
                      ))
                    ],
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: FlatButton(
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {

              },
              color: Color(0xffff8020),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
            ),
          )
        ],
      ),

    );
  }
}
