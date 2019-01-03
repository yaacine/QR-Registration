import 'package:flutter/material.dart';
import './scanPage.dart';
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
      routes: <String,WidgetBuilder>{
        "/ScanPage" : (BuildContext context) => new ScanPage(),
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
