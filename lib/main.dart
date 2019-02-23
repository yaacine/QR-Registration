import 'package:flutter/material.dart';
import './views/scanPage.dart';
import './views/loginPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      routes: <String,WidgetBuilder>{
        "/ScanPage" : (BuildContext context) => new ScanPage(),
        "/LoginPage" : (BuildContext context) => new LoginPage(),
      
      },
      
      //home: ListFilesPage(title: "Choose a file"),
      home: LoginPage(),
      
    );
  }
}

