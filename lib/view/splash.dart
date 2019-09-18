import 'dart:math';

import 'package:flutter/material.dart';

import '../controller.dart';
import '../globals.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _winkingController;
  AnimationController _titleController;
  AnimationController _subTitleController;

  Animation _animation;
  Animation _winkingAnimation;
  Animation _titleAnimation;
  Animation _subTitleAnimation;


  @override
  void initState() {

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _winkingController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _titleController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _subTitleController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
    ..addStatusListener((status) async{
      if(status == AnimationStatus.completed){
        _winkingController.forward();
      }
    });

    _winkingAnimation = Tween(begin: pi /2, end: 0.0).animate(CurvedAnimation(parent: _winkingController, curve: Curves.linear))
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _titleController.forward();
      }
    });

    _titleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _titleController, curve: Curves.linear))
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _subTitleController.forward();
      }
    });

    _subTitleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _subTitleController, curve: Curves.linear))
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        Globals.controller = Controller();
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
    super.initState();
    _controller.forward();
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
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
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
                    AnimatedBuilder(
                      child: AnimatedBuilder(
                        child: Image.asset('assets/logo_open_eyed.png', width: 117, height: 164,),
                        builder: (context, child){
                          return Stack(
                            children: <Widget>[
//                              Container(
//                                color: Colors.transparent,
//                              ),
                              Image.asset('assets/logo.png', width: 117, height: 164,),
                              Opacity(
                                opacity: sin(_winkingAnimation.value),
                                child: child,
                              ),
                            ],
                          );
                        },
                        animation: _winkingAnimation,
                      ),
                      animation: _animation,
                      builder: (context, child){
                        return Opacity(
                          opacity: _animation.value,
                          child: child,
                        );
                      },
                    ),
                    AnimatedBuilder(
                      child: Image.asset('assets/ticketawy.png', width: 225.5, height: 50.75,),
                      animation: _titleAnimation,
                      builder: (context, child){
                        return Opacity(
                          opacity: _titleAnimation.value,
                          child: child,
                        );
                      },
                    ),
                    AnimatedBuilder(
                      child: Image.asset('assets/ticket_easy.png', width: 119.5, height: 25.75,),
                      animation: _subTitleAnimation,
                      builder: (context, child){
                        return Opacity(
                          opacity: _subTitleAnimation.value,
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0, right: 0.0, bottom: 0.0,
              child: Image.asset('assets/splash_footer.png',),
            ),
          ],
        ),
      ),
    );
  }
}
