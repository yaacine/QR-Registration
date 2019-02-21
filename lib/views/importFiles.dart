import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import './listFilesPage.dart';
import 'globalCompounents.dart';
class ImportFilesPage extends StatefulWidget {
  _ImportFilesPageState createState() => _ImportFilesPageState();
}

class _ImportFilesPageState extends State<ImportFilesPage> {
  @override


  Widget build(BuildContext context) {

    final loadingAnimation = Container(
       child:new Center(
        child: SizedBox(width: 300.0, height: 300.0,
        child: DecoratedBox(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20.0),
             color: Color.fromRGBO(40, 80, 60, 0.5),
             
             
           ),
          child:Center(

           child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                 child:CircularProgressIndicator(strokeWidth: 4.0,
                  ),
                ),
                
                SizedBox(height: 10.0,),
                Padding(
                   padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text("Loading..." , style: TextStyle(fontSize: 15.0),),
                )

           
             ],
           ) 
          ) 
           
         ),)
        
       )
    );


    final loadFilesButton = Container(
      child: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Icon(Icons.file_download , size: 180.0,color: Colors.white,) ,
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child:  RaisedButton(
                    elevation: 8.0,
                    color: Color.fromRGBO(243, 177, 11, 0.8),
                    //backgroundColor: Color.fromRGBO(243, 177, 11, 0.8),
                    onPressed: (){
                      // load listFilesPage here
                      if(SheetsManager.sheets==null || SheetsManager.sheets.length==0){
                        print("error while loading files , check your connexion and retry again");
                      }
                      else{
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> ListFilesPage(files:SheetsManager.sheets) 
                      ));
                      }
                      
                    },
                    child:
                    Padding(
                      padding: EdgeInsets.all(10.0),                      
                      child:  Column(   
                      children: <Widget>[   

                        Text('Import shared sheets' , style: TextStyle(color: Colors.white , fontSize: 20.0),)

                      ],
                    ) ,
                    )
                   ),            
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: generalAppbar(context, "Import Files")
            ,
      body: loadFilesButton,
    );
    
    //SheetsManager.isLoading== true? Center(child: Text("data"),): loadingAnimation;
  }
}

