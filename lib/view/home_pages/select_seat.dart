import 'package:flutter/material.dart';

import '../../globals.dart';

List<List<bool>> _list1 = [
  [false, false, true, false, true, false],
  [false, true, false, false, true, true],
  [true, false, true, false, true, false],
  [false, false, false, false, false, false],
  [true, false, true, false, false, false],
];

List<List<bool>> _list2 = [
  [false, false, true, false, false, false],
  [false, false, false, true, true, false],
  [false, false, true, false, true, false],
  [false, true, false, false, true, false],
  [true, false, true, false, false, false],
];

List<List<bool>> _list3 = [
  [false, false, false, false, true, false],
  [false, false, false, false, false, false],
  [true, false, true, false, false, true],
  [false, false, false, false, false, false],
  [false, false, false, false, true, false],
];

List<List<bool>> _list4 = [
  [true, false, false, false, true, false],
  [false, true, false, true, false, false],
  [false, false, false, true, false, false],
  [true, false, false, false, false, true],
  [false, false, true, false, true, false],
];

class SelectSeat extends StatelessWidget {

  final Function onPreviousPagePressed;

  final Function onSeatsBooked;
  final Function onAllCategoriesPressed;

  SelectSeat({@required this.onPreviousPagePressed, @required this.onSeatsBooked, @required this.onAllCategoriesPressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.selectSeatPageIndex);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Event name
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width > 360?8.0 : 4.0),
            child: Text('Event name here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff767676),
                fontSize: MediaQuery.of(context).size.width > 360?25:20,
                fontFamily: 'Verdana',
              ),
            ),
          ),

          // The title
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width > 360?8.0 : 4.0),
            child: Text('Select Seat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: MediaQuery.of(context).size.width > 360?25:20,
              ),
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _row(
                [_list1, _list2]
              ),
              _row(
                [_list3, _list4]
              ),
            ],
          ),

          _legend(context),

          Padding(
            padding: const EdgeInsets.only(right: 80.0, left: 80.0),
            child: ListTile(
              onTap: onSeatsBooked,
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

  Widget _row(List list){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(list.length, (index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SeatsArea(
            list: list[index],
          ),
        );
      }),
    );
  }

  Widget _legend(BuildContext context){

    Map _map = {
      'Free': 0xff929292,
      'Reserved' : 0xff4b3d7a,
      'Selected' : 0xffff6600,
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index){
        return _legendItem(context, _map[_map.keys.toList()[index]], _map.keys.toList()[index]);
      }),
    );
  }

  Widget _legendItem(BuildContext context, int colorCode, String indication){

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Color(colorCode),
            height: MediaQuery.of(context).size.width > 360?25:20,
            width: MediaQuery.of(context).size.width > 360?25:20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(indication,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 360?20:17
            ),
          ),
        ),
      ],
    );
  }


}

class SeatsArea extends StatefulWidget {

  final List<List<bool>> list;

  SeatsArea({@required this.list});
  @override
  _SeatsAreaState createState() => _SeatsAreaState();
}

class _SeatsAreaState extends State<SeatsArea> {



  @override
  Widget build(BuildContext context) {

    return Column(
      children: List.generate(widget.list.length, (index){
        return _row(widget.list[index]);
      }),
    );
  }

  Widget _row(List<bool> list){
    final _width = MediaQuery.of(context).size.width;
    return Row(
      children: List.generate(list.length, (index){
        return Padding(
          padding: EdgeInsets.all(_width > 360?3.0: 2),
          child: SeatItem(
            reserved: list[index],
          ),
        );
      }),
    );
  }
}

class SeatItem extends StatefulWidget {

  final bool reserved;

  SeatItem({@required this.reserved});

  @override
  _SeatItemState createState() => _SeatItemState();
}

class _SeatItemState extends State<SeatItem> {



  bool _selected = false;
  bool _reserved = false;

  @override
  void initState() {
    super.initState();
    _reserved = widget.reserved;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        if(!_reserved){
          setState(() {
            _selected = _selected?false:true;
          });
        }
      },
      child: Container(
        color: _reserved? Color(0xff4b3d7a): _selected? Color(0xffff6600):Color(0xff929292),
        height: _width > 360?25:20,
        width: _width > 360?25:20,
      ),
    );
  }
}





