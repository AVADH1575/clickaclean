import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/login/UserAuth.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_widget.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginEmailScreen extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginEmailScreen();
  }
}

class _LoginEmailScreen extends State<LoginEmailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _btnEnabled = false;
  bool _isVisible = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  new Form(
            key: _key,
            autovalidate: _validate,
            child:


            Padding(
                padding: EdgeInsets.all(0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: Color.fromRGBO(125, 121, 204, 1),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Padding(
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/white-logo.svg',

                                // fit: BoxFit.contain,
                                height: 50,


                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                              child: Align(
                                alignment: Alignment.topLeft,

                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text: 'Login/Create Account \n',
                                    style: TextStyle(color: Colors.white,fontSize: 20.0 ), /*defining default style is optional */
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'To get personalised experience', style: TextStyle(color: Colors.white,fontSize: 18.0)),

                                    ],
                                  ),
                                ),

                              )),
                        ],

                      ),
                    ),


                    Container(
                      padding: EdgeInsets.fromLTRB(20,30,20,0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        child:

                        TextFormField(
                          controller: EmailControler,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            hintText: 'Enter Your Email ID',
                            ),),    ), ),

            Container(
              padding: EdgeInsets.fromLTRB(20,20,20,0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,0,0,5),
                child: TextFormField(
               controller: passwordController,
                  obscureText: !_showPassword,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",

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
                    Container(
                        padding:EdgeInsets.fromLTRB(10, 15, 10, 0) ,
                        child: Column(
                          children: <Widget>[
                            Center(

                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Your personal details are secure with us.Read our',
                                  style: TextStyle(color: Color.fromRGBO(169, 189, 212, 1),fontSize: 12.5 ), /*defining default style is optional */
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Privacy', style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(241, 123, 72 ,1),fontSize: 12.5)),
                                    TextSpan(
                                        text: ' Policy',
                                        style: TextStyle(color: Color.fromRGBO(241, 123, 72 ,1),fontSize: 12.5,fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: ' to know more.By Proceeding further you agree to our\n',
                                        style: TextStyle(color: Color.fromRGBO(169, 189, 212, 1), fontSize: 12.5)),
                                    TextSpan(
                                        text: 'Terms and Conditions ',
                                        style: TextStyle(color: Color.fromRGBO(241, 123, 72 ,1), fontSize: 12.5,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),),

                            FlatButton(
                              textColor: Colors.grey,
                              onPressed: () {
                                //signup screen
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,

                        )),
                    SizedBox(height: 10),
                    Container(
                      padding:EdgeInsets.fromLTRB(10, 0, 10, 0) ,
                      child: Column(
                          children: <Widget>[
                      Center(

                      child:RaisedButton(
                          color:Color.fromRGBO(125, 121, 204, 1),
                      onPressed: () {
                        validateEmail(EmailControler.text,passwordController.text);

//                        _navigateToNextScreen1(context);
                      },
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      child: const Text('SUBMIT', style: TextStyle(fontSize: 20,color:Colors.white)),
                    ),


                      ),]),
                    ),


                  ],
                ))));
  }

  String validateEmail(String email,String password) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (email.length == 0) {
      Fluttertoast.showToast(msg: "Please enter email address");
      return "Email is Required";
    }
   else if (password.length == 0) {
      Fluttertoast.showToast(msg: "Please enter passsword");
      return "password is Required";
    }
    else if(!regExp.hasMatch(email)){
      Fluttertoast.showToast(msg: "Invalid email address");
      return "Invalid Email";
    }
    else {
      Auth().signUp(context,EmailControler.text, passwordController.text);
    }
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Otp()),
    );
  }
  void _navigateToNextScreen1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
    );
  }
}
