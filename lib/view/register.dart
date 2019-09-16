import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
//                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage('assets/background.png')
                  )
              ),
            ),

            //The registration form
            Positioned(
              left: 0.0,
              right: 0.0,
              top: _height / 8,
              bottom: 0.0,
              child: ListView(
                children: <Widget>[
              Image.asset('assets/header.png', width: 161, height: 142,),
                  Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[

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

                            // Phone
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0,),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.phone_iphone),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        style: BorderStyle.none,
                                      )
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  labelText: 'Phone',
                                ),
                                validator: (value){
                                  return null;
                                },
                              ),
                            ),

                            // register button
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0,),
                              child: ListTile(
                                title: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color(0xfffe6700),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text('Sign Up',
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

                            // Sign in link text
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('Have an account?',
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
                      )
                    ],
                  )
                ],
              ),
            ),

            //The back arrow
            Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                        Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
