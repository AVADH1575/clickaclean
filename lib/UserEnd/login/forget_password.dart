import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/login/UserAuth.dart';
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

class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgetPassword();
  }
}

class _ForgetPassword extends State<ForgetPassword> {
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

        appBar: AppBar(
          title: const Text('Forget Password?'),
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
                      padding: EdgeInsets.fromLTRB(20,30,20,0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        child:

                        TextFormField(
                          controller: EmailControler,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.black45,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
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
                              hintText: "New Password",

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
                      padding:EdgeInsets.fromLTRB(20, 20, 20, 20) ,
                      child: Column(
                          children: <Widget>[
                            Center(
                              child:RaisedButton(
                                color:Color.fromRGBO(125, 121, 204, 1),
                                onPressed: () {
                                  validateEmail(EmailControler.text,passwordController.text);
                                },
                                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                child: const Text('SUBMIT', style: TextStyle(fontSize: 20,color:Colors.white)),
                              ),

                            ),]),
                    ),




                  ],
                ))));


  }



  String validateEmail(String email, String password) {

    if (email.length == 0) {
      Fluttertoast.showToast(msg: "Please enter Phone Number");
      return "Phone number is Required";
    }
    else if (password.length == 0) {
      Fluttertoast.showToast(msg: "Please enter  passsword");
      return "password is Required";
    }
    else {
      Auth().signUp(context, EmailControler.text, passwordController.text);
    }
  }

  // void _navigateToNextScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ForgotPassword()),
  //   );
  // }

}
