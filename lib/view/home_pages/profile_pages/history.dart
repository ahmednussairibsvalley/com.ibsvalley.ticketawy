import 'package:flutter/material.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';

class ProfileHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistoryPage();
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
            imageUrl: 'https://s3.amazonaws.com/busites_www/yanni/home_bg_2_1525800103.jpg',
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
            children: <Widget>[

              // Event image
              Image.network(imageUrl),

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
                padding: const EdgeInsets.all(8.0),
                child: Text(code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
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

