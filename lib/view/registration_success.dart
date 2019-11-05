import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import '../util.dart' as util;
import 'dashed_divider.dart';
import 'home.dart';

class RegistrationSuccessDialog extends StatefulWidget {
  final String message;
  final String password;
  final String id;
  final bool openedFromEventDescription;

  RegistrationSuccessDialog({@required this.message, @required this.password,
    @required this.id, this.openedFromEventDescription = false});
  @override
  _RegistrationSuccessDialogState createState() => _RegistrationSuccessDialogState();
}

class _RegistrationSuccessDialogState extends State<RegistrationSuccessDialog> {

  bool _confirming = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        // title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.message.isNotEmpty && widget.message != null ? widget.message : 'Success',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'GeometriqueSans',
            ),
          ),
        ),

        // dashed divider
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DashedDivider(),
        ),

        // message
        Expanded(
          child: Text(
            'Registered With Success',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Verdana',
              fontSize: 17,
            ),
          ),
        ),

        // the close button
        ListTile(
          enabled: _confirming?false:true,
          onTap: () async {
            setState(() {
              _confirming = true;
            });
            Globals.skipped = false;
            Globals.userPassword =
            widget.password != null && widget.password.isNotEmpty ? widget.password : '';
//                    Globals.userId = response['id'];
            Globals.userId = widget.id != null && widget.id.isNotEmpty ? widget.id : '';
            Map userData = await util.getUserDetails();

            SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setString(
                'userId', widget.id != null && widget.id.isNotEmpty ? widget.id : '');
            prefs.setString('fullName', userData['fullName']);
            prefs.setString('phoneNumber', userData['phoneNumber']);
            prefs.setString(
                'password',
                widget.password != null && widget.password.isNotEmpty
                    ? widget.password
                    : '');

            Navigator.of(context).pop();
            if(widget.openedFromEventDescription)
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(
                    currentPageIndex:
                    PagesIndices
                        .eventPageIndex,
                  )));
            else
              Navigator.of(context).pushReplacementNamed('/home');
          },
          title: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _confirming?Colors.grey:Color(0xfffe6700),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _confirming?'':'Done',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _confirming?Positioned(
                right: 0.0, left: 0.0,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SpinKitFadingCircle(
                        itemBuilder: (context , int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffff6600),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ):
              Container(),
            ],
          ),
        )
      ],
    );
  }
}