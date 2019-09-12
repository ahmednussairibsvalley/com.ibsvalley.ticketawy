import 'package:flutter/material.dart';
import 'package:ticketawy/view/register.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[

          // The background
          Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                    fit: BoxFit.fill,
//                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: AssetImage('assets/background.png')
                )
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            top: _height / 8,
            bottom: 0.0,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logo.png', width: 88, height: 123,),
                      Text('Ticketawy',
                        style: TextStyle(
                          fontFamily: 'TicketawyFont',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),

                      ),
                      Text('Ticket Easy!',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Umy',
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffe6700),
                        ),
                      ),
                    ],
                  ),

                  // User name.
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0,),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          )
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelText: 'User name',
                      ),
                      validator: (value){
                        return null;
                      },
                    ),
                  ),

                  // Password.
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0,),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: Icon(Icons.help_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              style: BorderStyle.none,
                            )
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelText: 'Password',
                      ),
                      validator: (value){
                        return null;
                      },
                    ),
                  ),

                  // login button
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0,),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed('/home');
                      },
                      title: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xfffe6700),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sign up link text
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Register()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('Don\'t have an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Color(0xfffe6700),
                  child: Text(
                    'Skip This Step',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
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
