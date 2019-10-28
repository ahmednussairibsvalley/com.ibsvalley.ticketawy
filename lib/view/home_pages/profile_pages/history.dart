import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';

import '../../../globals.dart';
import '../../../util.dart' as util;

class ProfileHistory extends StatelessWidget {
  final Function(String) onHistoryItemPressed;
  ProfileHistory({
    @required this.onHistoryItemPressed,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                return FutureBuilder(
                  future: util.getOrdersHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return HistorySlider(
                          list: snapshot.data,
                          onHistoryItemPressed: onHistoryItemPressed,
                        );
                      }
                      return Center(
                        child: Text('You don\'t have any orders'),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Center(
                child: Text('There is no connection'),
              );
            }
          }
          return Container();
        }
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}

class HistorySlider extends StatefulWidget {
  final List list;
  final Function(String) onHistoryItemPressed;

  HistorySlider({@required this.list, @required this.onHistoryItemPressed});
  @override
  _HistorySliderState createState() => _HistorySliderState();
}

class _HistorySliderState extends State<HistorySlider>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Map> paisList = List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.list.length; i++) {
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if (first >= widget.list.length) {
        break;
      } else {
        pairs['first'] = first;
      }

      if (second >= widget.list.length) {
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }
    _tabController = TabController(
      vsync: this,
      length: paisList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: List.generate(_tabController.length, (index) {
        List list = List();
        if (paisList[index]['second'] > 0) {
          list.add(widget.list[paisList[index]['first']]);
          list.add(widget.list[paisList[index]['second']]);
        } else {
          list.add(widget.list[paisList[index]['first']]);
        }
        return HistoryPage(
          list: list,
          onHistoryItemPressed: widget.onHistoryItemPressed,
        );
      }),
    );
  }
}

class HistoryPage extends StatelessWidget {
  final List list;
  final Function(String) onHistoryItemPressed;

  HistoryPage({@required this.list, @required this.onHistoryItemPressed});
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(list.length, (index) {
        return HistoryItem(
          imageUrl: '${Globals.imageBaseUrl}/${list[index]['event_Logo']}',
          orderDate: list[index]['orderdate'],
          orderId: '${list[index]['order_Id']}',
          totalPrice: list[index]['total_Price'],
          title: list[index]['event_Name'],
          code: '#${list[index]['order_Id']}',
          status: list[index]['status'],
          quantity: list[index]['number_of_tickets'],
          payment: list[index]['paymentMethod'],
          onItemHistoryPressed: onHistoryItemPressed,
        );
      }),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String orderId;
  final String imageUrl;
  final String title;
  final String code;
  final int quantity;
  final double totalPrice;
  final String orderDate;
  final String payment;
  final String status;
  final Function(String) onItemHistoryPressed;

  HistoryItem({
    Key key,
    @required this.orderId,
    @required this.imageUrl,
    @required this.title,
    @required this.code,
    @required this.totalPrice,
    @required this.orderDate,
    @required this.quantity,
    @required this.payment,
    @required this.status,
    @required this.onItemHistoryPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    DateTime _orderDate = DateTime.parse(orderDate);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),

              // Event title
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: Container(
                  height: 23,
                  child: Text(
                    title,
                    softWrap: true,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              // Divider
              Padding(
                padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: DashedDivider(
                  height: 1,
                  width: 5,
                  color: Colors.grey,
                ),
              ),

              // Order date
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Date: ${_orderDate.year}-${_orderDate.month}-${_orderDate.day}',style: TextStyle(fontSize: 16),),
              ),

              // Payment
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Payment: $payment',style: TextStyle(fontSize: 16),),
              ),

              // Status
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Status: $status',style: TextStyle(fontSize: 16),),
              ),

              // Divider
              Padding(
                padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: DashedDivider(
                  height: 1,
                  width: 5,
                  color: Colors.grey,
                ),
              ),

              // code
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: Text('Code: $code'
                  ,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),

              // Ticket Type
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 8.0),
                child: GestureDetector(
                  onTap: () {
                    onItemHistoryPressed(orderId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xfffe6700),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 9, right: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                              child: Image.asset(
                            'assets/ticket_type.png',
                            width: 35,
                            height: 35,
                          )),
                          Flexible(
                            child: Column(children: <Widget>[
                              Text(
                                '$quantity Tickets',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0,bottom: 4),
                                child: DashedDivider(
                                  height: 1,
                                  width: 5,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${totalPrice.toStringAsFixed(0)} EGP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Delete history
//              Padding(
//                padding: const EdgeInsets.only(top: 8.0, right: 4.0, left: 4.0),
//                child: Container(
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(30),
//                    color: Color(0xfffe6700),
//                  ),
//                  child: Padding(
//                    padding: const EdgeInsets.only(top: 4 , bottom: 4 , left: 9 , right: 9),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Image.asset('assets/delete_history.png', width: 35, height: 35,),
//                        Text('Delete history',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.white,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
