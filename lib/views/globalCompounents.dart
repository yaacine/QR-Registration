import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import 'loginPage.dart';



 AppBar generalAppbar(BuildContext context ,String title) => AppBar(
      leading: null,
      title: Center(child: Text(title),),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (_){SheetsManager.googleSignIn.signOut();},
          itemBuilder: (BuildContext context){
            return[
              PopupMenuItem(
                
               child:Row(children: <Widget>[
                 Text("Log out"),
                 Icon(Icons.account_circle),
               ],)
               )

             
            ];
          },
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


 