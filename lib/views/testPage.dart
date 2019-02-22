import 'package:flutter/material.dart';


class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool submit = false;
  @override
  Widget build(BuildContext context) {
    
    return Container(
       child:Column(
         children: <Widget>[
           Padding(child: submit? new Text('data'):
       CircularProgressIndicator(),
       padding: EdgeInsets.all(20.0),
       ),

         RaisedButton(
         child: Text("data"),
         onPressed: () {setState(() {
              this.submit = !submit; 
              print(submit);
          });}
        )
       
      
         ],
       ) 
    );
  }
}