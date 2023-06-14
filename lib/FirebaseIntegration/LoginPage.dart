import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'FirebaseHandler.dart';



class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>{
  FirebaseHandler fbHandler = FirebaseHandler();
  @override
  void initState() {
    super.initState();

    setDeeplinkClickHandler(fbHandler);
    setDeeplinkBGHandler(fbHandler);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 167, 255, 1),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child:Text("Login Form"),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[

                          FlatButton(
                            onPressed:(){
                              fbHandler.sendEmail(email: "ginnysahni16@gmail.com");
                            },
                            child: Text("Submit"),
                          )

                        ],
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top:40.0),
               //   child: LoginSchemes(),
                ),
              ],
            )
        ),
      ),
    );
  }

  setDeeplinkClickHandler(FirebaseHandler fbHandler){
    fbHandler.getDynamiClikData().then((link){
      if(link!=null){
        print('Deep link found $link ******');
       // Navigator.pushNamed(context, '/dashboard');
      }
    },
        onError:(err){
          print('=====Error link $err');
        });
  }

  setDeeplinkBGHandler(FirebaseHandler fbHandler){
    fbHandler.getDynamiBGData().then((boolValue){
      // Take action, you can also put logic to transit to another screen
      if(boolValue){
        print('Deep link found ******');
      }
    },
        onError: (err){
          print('Error $err');
        });
  }
}