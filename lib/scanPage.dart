import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barcode = "";
  String token = "";
  String checkInMsg = "Checked";
  bool tokenTaken = false;
  // auth

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
    ],
  );
  getToken() {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        token = googleKey.accessToken;
        print(googleKey.accessToken);

        setState(() => tokenTaken = true);
        print(_googleSignIn.currentUser.displayName);
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: getToken,
                    child: const Text('Get Google Token')),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    "Got Token ? " + tokenTaken.toString(),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    if(!tokenTaken){
      setState(() {
        this.barcode = 'You dont have acces token';
      });
    }else{
      try {
        String barcode = await BarcodeScanner.scan();
        var url = "https://sheets.googleapis.com/v4/spreadsheets/1JuUdv_acv0k6exTI350LrmPmt5GIfWkVNsdwy11tj4E/values/C"+barcode+":C"+barcode+"?valueInputOption=USER_ENTERED";
        http.put(url, headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer "+token
        }, body: jsonEncode({"values": [[checkInMsg]]}) ).then((response) {
          print("Response status: ${response.statusCode}");
          print("Response body: ${response.body}");
        });
        setState(() => this.barcode = barcode);
      } on FormatException {
        setState(() => this.barcode =
        'null (User returned using the "back"-button before scanning anything. Result)');
      } on PlatformException catch (e) {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
          setState(() {
            this.barcode = 'The user did not grant the camera permission!';
          });
        } else {
          setState(() => this.barcode = 'Unknown error: $e');
        }
      } catch (e) {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }


  }
}
