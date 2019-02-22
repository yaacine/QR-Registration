import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import 'loginPage.dart';



 AppBar generalAppbar(BuildContext context ,String title) => AppBar(
      leading: null,
      title: Center(child: Text(title),),
      actions: <Widget>[
        Padding(

          padding: EdgeInsets.symmetric(vertical: 8.0 , horizontal: 10.0),
          child:  RaisedButton(
          color: Color.fromRGBO(64, 100, 96, .9),
          child: Row(children: <Widget>[
                 Text("Log out"),
                 Icon(Icons.account_circle),
               ],),
          onPressed: (){
              
            SheetsManager.googleSignIn.signOut();
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context)=> LoginPage()
              )
            
            );
          },
        ),     
        )
       
        
      ],
    );





  // connexion dialog 
  AlertDialog checkConnexionDialog(BuildContext context) =>AlertDialog(
      title: const Text("Connexion Error !" , textDirection: TextDirection.ltr),
      content: Text('Check your internet connexion and try again .'),
      actions: <Widget>[
        FlatButton(
          child:Text("OK"),
          onPressed: (){
            Navigator.pop(context ,'OK');
          },
          )
      ],
      );


 