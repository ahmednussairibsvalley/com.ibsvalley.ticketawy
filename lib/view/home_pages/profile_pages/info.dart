import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'User name',
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
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Password',
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
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10,),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Phone',
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
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30,),
            child: ListTile(
              title: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Update',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xfffe6700),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
