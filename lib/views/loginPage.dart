import 'package:flutter/material.dart';
import '../controllers/participentsSheetController.dart';
import '../controllers/networkManager.dart';
import './globalCompounents.dart';
import './importFiles.dart';


/**
 * this page is for google login
 */

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool progressActive = false;
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
                  onPressed:() async{
                    //start the circular progress indicator
                    setState(() {
                     this.progressActive = true; 
                    });
                    //test connaxion then login
                    bool onValue= await NetworkManager.tryConnexion();

                        
                      if(onValue ){
                        
                       await SheetsManager.getToken();

                       // stop the circular progress indicator
                       setState(() {
                        this.progressActive= false; 
                       });
                       Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=> ImportFilesPage()
                    ));
                    }else { 
                      // no  intenet connexion
                      setState(() {
                        this.progressActive= false; 
                       });
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => checkConnexionDialog(context)
                      ); 
                    }
         
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
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0 ,horizontal: 20.0),
            child:Center(child:  this.progressActive== true? CircularProgressIndicator(): null),)

        
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



