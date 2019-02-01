import 'package:flutter/material.dart';
import './scanPage.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'Sheet.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/ScanPage": (BuildContext context) => new ScanPage(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Sheet> sheets = [];
  String token = "ya29.GlujBtbh6qLdMemIw6LaJtR-whdPHDPfEcNjXFUycOoN8vatFEKve0Ckx4nBAJsKADgrxHDCOFYCVTZF5y20KduhZiyJJYFKb-hfe1ikGDbybuqRzzyVlyZ7PlWv"; // testToken
  bool tokenTaken = false;
  bool isLoading = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );

  Future<List<Sheet>> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        "https://www.googleapis.com/drive/v3/files?corpora=user&orderBy=modifiedTime desc&q=mimeType = \"application/vnd.google-apps.spreadsheet\"",
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          "Authorization": "Bearer " + token
        });
    if (response.statusCode == 200) {
      print(">---------------------- RESPONSE ---------------------");
      print(response.body);
      print(">---------------------- END RESPONSE ---------------------");
      setState(() {
        isLoading = false;
      });
      return parseFiles(response.body);
    } else {
      throw Exception('Failed to load files');
    }
  }

  getToken() {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        //token = googleKey.accessToken;
        print(googleKey.accessToken);
        setState(() => tokenTaken = true);
        setState(() {
          token = googleKey.accessToken;
        });
        print(_googleSignIn.currentUser.displayName);
        _fetchData().then( (res) {
            print(">---------------------- THEN ---------------------");
            setState(() {
              sheets = res;
            });
        });

      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }

  List<Sheet> parseFiles(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    return parsed['files'].map<Sheet>((json) => Sheet.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: new Column(
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
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: () {
                Navigator.of(context).pushNamed("/ScanPage");
              },
              child:
                  new Text("Go to scan screen", textDirection: TextDirection.ltr),
            ),
          ),
          new Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: sheets.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(sheets[index].name);
              },
            ),
          )
        ],
      )),
    );
  }
}
