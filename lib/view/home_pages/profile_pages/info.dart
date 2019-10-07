import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util.dart' as util;

class ProfileInfo extends StatefulWidget {

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool _updating = false;

  @override
  void initState() {
    super.initState();
    initValues();
  }

  initValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.get('fullName');
    String password = prefs.get('password');
    String phoneNumber = prefs.get('phoneNumber');

    print('${prefs.get('password')}');

    _fullNameController.value = _fullNameController.value.copyWith(text: fullName);
    _passwordController.value = _passwordController.value.copyWith(text: password);
    _phoneNumberController.value = _phoneNumberController.value.copyWith(text: phoneNumber);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              // User name
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'User name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your user name.';
                    }
                    return null;
                  },
                ),
              ),

              // Password
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
              ),

              // Phone
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
                child: TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Phone',
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your phone.';
                    }
                    return null;
                  },
                ),
              ),

              // Update Button
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: ListTile(
                  onTap: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        _updating = true;
                      });

                      Map userDataUpdated = await util.updateUserDetails(
                          fullName: _fullNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          password: _passwordController.text,
                      );

                      if(userDataUpdated['result']){

                        Map userData = await util.getUserDetails();

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('fullName', userData['fullName']);
                        await prefs.setString('password', _passwordController.text);
                        await prefs.setString('phoneNumber', userData['phoneNumber']);

                      }

                      setState(() {
                        _updating = false;
                      });
                    }
                  },
                  title: Material(
                    shadowColor: Colors.black,
                    elevation: 10,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'MyriadPro'
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        _updating?
        Positioned(
          left: 0.0, right: 0.0, top: 0.0, bottom: 0.0,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height: 50, width: 50,child: CircularProgressIndicator()),
              ],
            ),
          ),
        )
            :Container()
      ],
    );
  }
}
