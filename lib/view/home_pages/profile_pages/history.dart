import 'package:flutter/material.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';

class ProfileHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistorySlider();
  }
}


class HistorySlider extends StatefulWidget {
  @override
  _HistorySliderState createState() => _HistorySliderState();
}

class _HistorySliderState extends State<HistorySlider> with TickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );
  }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: List.generate(_tabController.length, (index){
        return HistoryPage();
      }),
    );
  }
}


class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: HistoryItem(
            imageUrl: 'https://s3.amazonaws.com/busites_www/yanni/home_bg_2_1525800103.jpg',
            title: 'Event name here',
            code: '#123456789',
          ),
        ),
        Flexible(
          child: HistoryItem(
            imageUrl: 'https://www.liffed.com/wp-content/uploads/2018/09/de853fb9_3088_4da5_b4a7_a54ef2181ecb_a21b0077-99fe-4b74-9a87-11bd3f3b82a3.jpg',
            title: 'Event name here',
            code: '#123456789',
          ),
        ),
      ],
    );
  }
}

class HistoryItem extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String code;

  HistoryItem({Key key, @required this.imageUrl, @required this.title, @required this.code}):  super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Image.network(imageUrl,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),

              // Event title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),



              // Divider
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DashedDivider(
                  height: 1,
                  width: 5,
                  color: Colors.grey,
                ),
              ),

              // code
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),

              // Ticket Type
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xfffe6700),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4 , bottom: 4 , left: 9 , right: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/ticket_type.png', width: 35, height: 35,),
                        Text('Class A 120\$',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Delete history
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xfffe6700),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4 , bottom: 4 , left: 9 , right: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/delete_history.png', width: 35, height: 35,),
                        Text('Delete history',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
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

