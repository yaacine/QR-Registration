import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/participentsSheetController.dart';
import '../models/sheet.dart';
import './scanPage.dart';


class ListFilesPage extends StatefulWidget {

  ListFilesPage({Key key, this.files}) : super(key: key); // passing the sheets to siplay them
  List<Sheet> files;
  _ListFilesPageState createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
  List filesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.filesList = getFilesList();
  }
  @override
  Widget build(BuildContext context) {
    final String title="";
    final topAppBAr = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(78, 76, 106, 1.0),
      title: Text("CHOOSE A FILE"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: (){},
        )
      ],


    );

    
    
    ListTile makeListTile(Sheet sheet1) =>ListTile(
     
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.white24),
          )
        ),
        child: Image.asset("assets/sheets.png")
      ),

      title: Text(
          sheet1.name.length>25 ? "${sheet1.name.substring(0,25)}..." : sheet1.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: <Widget>[
          Icon(Icons.attachment , color: Colors.yellowAccent),
          Text("Spreadsheet", style: TextStyle(color: Colors.white))
        ],
      ),

      trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: (){
        SheetsManager.sheetId = sheet1.id.toString() ;
        print("================"+SheetsManager.sheetId+ " \n\n");
        Navigator.push(context, MaterialPageRoute(
          builder:(context) => ScanPage()
        ));
      },
    );


    Card  makeCard(Sheet sheet1)=>Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9)
        ),
        child: makeListTile(sheet1),
      ),
    );


    final makeBody =Container(
      child: ListView.builder(
        itemCount: widget.files.length,
        itemBuilder: (BuildContext context , int index){
          return makeCard(widget.files[index]);
        },
      ),
    );

    
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBAr,
      body: makeBody,
      /*appBar: AppBar(title: new Text("CHOOSE FILE" , textDirection: TextDirection.ltr)
      ,),
      body: ListView.builder(
        itemCount: 10,  // modify the item count
        itemBuilder: (BuildContext context , int index){
          return Card(
            child: Row(
              children: <Widget>[

              ],
            ),
          );
        },
      ),*/
    );
  }
}