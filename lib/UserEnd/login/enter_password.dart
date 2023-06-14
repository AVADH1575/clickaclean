import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/login/UserAuth.dart';
import 'package:click_a_clean/UserEnd/login/password_set.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forget_password.dart';

class EnterPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EnterPassword();
  }
}

class _EnterPassword extends State<EnterPassword> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _btnEnabled = false;
  bool _isVisible = true;
  SharedPreferences myPrefs;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  TextEditingController EmailControler = new TextEditingController();

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool _showPassword = false;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  Future POST_LOGIN_API(String password) async {
    myPrefs = await SharedPreferences.getInstance();
    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_PHONE_LOGIN_URL,
          headers: {"x-api-key":  'boguskey'
          },

          body: {
            'phone': myPrefs.getString(STORE_PREFS.USER_ID_PHONE_NUMBER_GLOBAL),
            'password': password,
            "device_token": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
            "device_type": "Android"
          }
      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price_ListResponse status: ${response.statusCode}");
        print("pricel_ListResponse body: ${response.body}");

        var jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,jsonData["data"][0]["id"].toString());
            myPrefs.setString(STORE_PREFS.USER_API_KEY,jsonData["data"][0]["apiKey"].toString());

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
            );

          }

          else {

            Fluttertoast.showToast(msg: jsonData["message"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );

          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('Enter Password'),
          backgroundColor:Color.fromRGBO(125, 121, 204, 1),

        ),

        body: new Form(
            key: _key,
            autovalidate: _validate,
            child:
            Padding(
                padding: EdgeInsets.all(0),
                child: ListView(
                  children: <Widget>[

                    Container(
                      margin:EdgeInsets.only(top:50,left: 10,right: 10),
                        padding: EdgeInsets.fromLTRB(20,20,20,0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,0,0,5),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !_showPassword,
                            cursorColor: Colors.black45,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Enter Password",

                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglevisibility();
                                },
                                child: Icon(
                                  _showPassword ? Icons.visibility : Icons
                                      .visibility_off, color: Colors.black,),
                              ),
                            ),
                          ),)
                    ),
                    SizedBox(height: 10),
//                    Align(
//                      alignment: Alignment.centerRight,
//                      child:FlatButton(
//                        onPressed: (){
//                          _navigateToNextScreen(context);
//                        },
//                        child:
//                        Padding(
//                          padding: EdgeInsets.only(right: 10),
//                        child:Text("Forgot password?",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,fontSize: 12.5)),),
//                      )
//
//                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:EdgeInsets.fromLTRB(20, 20, 20, 20) ,
                      child: Column(
                          children: <Widget>[
                            Center(
                              child:RaisedButton(
                                color:Color.fromRGBO(125, 121, 204, 1),
                                onPressed: () {
                                  validateEmail(passwordController.text);
                                },
                                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                child: const Text('SUBMIT', style: TextStyle(fontSize: 20,color:Colors.white)),
                              ),

                            ),]),
                    ),




                  ],
                ))));


  }



  String validateEmail(String email) {

    if (email.length == 0) {
      Fluttertoast.showToast(msg: "Please enter password");
      return "password is Required";
    }

    else {
      POST_LOGIN_API(email);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetPassword()),
    );
  }

}
