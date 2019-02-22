import 'package:flutter/material.dart';
import './views/scanPage.dart';
import './views/loginPage.dart';
import './views/homePage.dart';
import './views/listFilesPage.dart';
import './views/importFiles.dart';


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
        "/HomePage" : (BuildContext context) => new HomePage(),
      },
      
      //home: ListFilesPage(title: "Choose a file"),
      home: LoginPage(),
      
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8.0),
                child: Text( 'GDG QR Code Scanner', ), 
            ),

            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8.0),
              child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: (){ Navigator.of(context).pushNamed("/ScanPage") ;},
                    child: new Text("SCAN A QR CODE" , textDirection: TextDirection.ltr)
                    ,
                  ),
            )
          
          ],
        )
       
      ),
    );
  }
}