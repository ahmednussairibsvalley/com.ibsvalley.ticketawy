import 'package:flutter/material.dart';

import '../../globals.dart';

class PaymentPage extends StatelessWidget {

  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;

  PaymentPage({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.paymentPageIndex);

    return Scaffold(
      body: Payment(),
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
    );
  }
}

class Payment extends StatefulWidget {
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<Payment> {
  String dropval;
  void dropChange(String val) {
    setState(() {
      dropval = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/payments.jpg",
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 250),
                  ),
                  Text(
                    'Payment',
                    style: TextStyle(
                      color: Color(0xffff8020),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 30),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)),
                      hint: Text('Credit card'),
                      onChanged: dropChange,
                      value: dropval,
                      items: <String>['Fawry', "Visa"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                  _nameOnCard(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  _cardNumber(),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 140,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child:
                              Material(
                                shadowColor: Colors.black, elevation: 4, shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none) ,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'CVV',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none)),
                                ),)
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                ),
                SizedBox(
                    width: 140,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child:

                              Material(
                                shadowColor: Colors.black, elevation: 4, shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none) ,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'EXP',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none)),
                                ),)

                          )
                        ],
                      ),
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 50,
                  child: FlatButton(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    onPressed: () {},
                    color: Color(0xffff8020),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _nameOnCard() {
    return SizedBox(
        width: 300,
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child:
                  Material(
                    shadowColor: Colors.black, elevation: 4, shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none) ,
                    child:                 TextField(
                      decoration: InputDecoration(
                          hintText: 'Name on card',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  )
              )
            ],
          ),
        ));
  }
  Widget _cardNumber() {
    return SizedBox(
        width: 300,
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child:
                  Material(
                    shadowColor: Colors.black, elevation: 4, shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none) ,
                    child:                 TextField(
                      decoration: InputDecoration(
                          hintText: 'Card number',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  )
              )
            ],
          ),
        ));
  }
}
