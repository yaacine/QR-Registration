import 'package:flutter/material.dart';
import '../controllers/loginController.dart';
import '../controllers/participentsSheetController.dart';
import './listFilesPage.dart';
import './importFiles.dart';
import '../controllers/participentsSheetController.dart';
import 'dart:async';

/**
 * this page is for google login
 */
class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final loginButton = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

            Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Icon(Icons.supervisor_account , color: Colors.white, size: 200,)
          ),

          Padding(
              padding:EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 16.0),
              child: RaisedButton(
                  elevation: 8.0,
                  color: Color.fromRGBO(243, 177, 11, 0.8),
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed:(){
                   
                    SheetsManager.getToken().then((value) {
                       Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=> ImportFilesPage()
                    ));
                    }) ;

                    // wait for json response
                  // SheetsManager.isLoading= false;
                    // load importfils page here 
                     

                  } ,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 0.0),
                    child: Row(children: <Widget>[
                    Image.asset("assets/google.png", height: 50, width:80), // google icon here
                    Text("Login with Google", style: TextStyle(fontSize: 25.0),)
                  ],)
                  )
   
              )
          ),

        
        ],
      ),
    );

   


    final makeBody = Center(
      child: loginButton,
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      
      body: makeBody,
      
    );

  }
}




/*

  

    final logo = Hero(
      tag : 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("assets/logo.png"),
      ),
    );
    final email =TextFormField(
      autofocus:false,
      keyboardType: TextInputType.emailAddress,
      initialValue: "example@gmail.com",
      decoration: InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
      
      );

       final password =TextFormField(
      autofocus:false,
      obscureText: true,
      initialValue: "example@gmail.com",
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
      );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical:16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            // use logi controller here
          },

          color: Colors.lightBlueAccent,
          child: Text("Log In" , style: TextStyle(color: Colors.white),),
        ),
      ),
    );


    final forgotPassword = FlatButton(
      child: Text(
        "Forgot password ?",
        style: TextStyle(color: Colors.black54)
      ),

      onPressed: (){
        // show a notification to ask gdg event manager to check pasword
      },
    );
    return Scaffold(
       backgroundColor: Colors.white,
       body: Center(
         child : ListView(
           shrinkWrap: true,
           padding: EdgeInsets.only(left:24.0 , right: 24.0),
           children: <Widget>[
             logo,
             SizedBox(height: 48.0,),
             email,
             SizedBox(height: 8.0,),
             password,
             SizedBox(height: 24.0,),
             loginButton, 
             forgotPassword


           ],
         )
       ),
    );
*/