import 'package:flutter/material.dart';

import '../../globals.dart';

class SelectSeat extends StatelessWidget {

  final Function onPreviousPagePressed;

  SelectSeat({@required this.onPreviousPagePressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.selectSeatPageIndex);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Event name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Event name here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff767676),
                fontSize: 25,
              ),
            ),
          ),

          // The title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Select Seat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: 25,
              ),
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _row(), _row(),
            ],
          ),

          _legend(),

          Padding(
            padding: const EdgeInsets.only(right: 80.0, left: 80.0),
            child: ListTile(
              title: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff6600),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Buy Tickets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
          ],
        ),
      ),
    );
  }

  Widget _row(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SeatsArea(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SeatsArea(),
        ),
      ],
    );
  }

  Widget _legend(){

    Map _map = {
      'Free': 0xff929292,
      'Reserved' : 0xff4b3d7a,
      'Selected' : 0xffff6600,
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index){
        return _legendItem(_map[_map.keys.toList()[index]], _map.keys.toList()[index]);
      }),
    );
  }

  Widget _legendItem(int colorCode, String indication){

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Color(colorCode),
            height: 25,
            width: 25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(indication,
            style: TextStyle(
              fontSize: 20
            ),
          ),
        ),
      ],
    );
  }


}

class SeatsArea extends StatefulWidget {
  @override
  _SeatsAreaState createState() => _SeatsAreaState();
}

class _SeatsAreaState extends State<SeatsArea> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index){
        return _row();
      }),
    );
  }

  Widget _row(){
    return Row(
      children: List.generate(6, (index){
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: SeatItem(),
        );
      }),
    );
  }
}

class SeatItem extends StatefulWidget {
  @override
  _SeatItemState createState() => _SeatItemState();
}

class _SeatItemState extends State<SeatItem> {

  bool _selected = false;
  bool _reserved = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _selected = _selected?false:true;
        });
      },
      child: Container(
        color: _reserved? Color(0xff4b3d7a): _selected? Color(0xffff6600):Color(0xff929292),
        height: 25,
        width: 25,
      ),
    );
  }
}





