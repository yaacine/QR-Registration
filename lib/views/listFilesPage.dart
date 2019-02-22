import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import '../models/sheet.dart';
import './scanPage.dart';
import './globalCompounents.dart';

class ListFilesPage extends StatefulWidget {

  ListFilesPage({Key key, this.files}) : super(key: key); // passing the sheets to siplay them
  List<Sheet> files;
  _ListFilesPageState createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final String title="";

    
    
    
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
      appBar: generalAppbar(context, "My Sheets"),
      body: makeBody,
    );
  }
}