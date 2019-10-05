import 'package:flutter/material.dart';

class MyWishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('My wishlist',
                style: TextStyle(
                  color: Color(0xffff6600),
                  fontSize: 17,
                  fontFamily: 'Verdana',
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
