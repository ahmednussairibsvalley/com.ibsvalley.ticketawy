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
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
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
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 250),
//                  ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _nameOnCard(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _cardNumber(),
                  ),
                ],
              ),
            ),
            //CVV & EXP
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                  //EXP
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
            ),

            //Confirm Button
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
                    child: Text('Confirm',
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
