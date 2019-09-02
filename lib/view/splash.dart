import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
    startApp();
  }

  startApp() async{

    return Timer(Duration(seconds: 4), (){
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: AssetImage('assets/background.png')
                )
              ),
            ),
            Positioned(
              left: 0.0, right: 0.0, top: 0.0, bottom: 0.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo.png', width: 117, height: 164,),
                    Text('Ticketawy',
                      style: TextStyle(
                        fontFamily: 'TicketawyFont',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
