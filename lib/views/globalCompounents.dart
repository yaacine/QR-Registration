import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import 'loginPage.dart';


 AppBar generalAppbar(BuildContext context ,String title) => AppBar(
      leading: null,
      title: Center(child: Text(title),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: (){
             // show  disconnect( logout ) menu here
             SheetsManager.googleSignIn.signOut();
             SheetsManager.sheets=null;
             Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context)=> LoginPage()
             )
             );
            
          },
        )
        
      ],
    );