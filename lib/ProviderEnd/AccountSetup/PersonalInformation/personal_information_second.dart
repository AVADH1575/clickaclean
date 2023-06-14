
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationSecond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalInformationSecond();
  }
}
class _PersonalInformationSecond extends State<PersonalInformationSecond> {
  TextEditingController email_field = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  SharedPreferences myPrefs;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _enabled = false;

  Future<void> checkStore()
  async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    print("==Firstname=="+myPrefs.getString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_FIRST_NAME).toString());
    print("==Lastname=="+myPrefs.getString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_LAST_NAME).toString());
    print("==Middlename=="+myPrefs.getString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_MIDDLE_NAME).toString());
    print("======check_phone"+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_CHECK_PHONE_GLOBAL).toString());

    if( myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_CHECK_PHONE_GLOBAL) == ""){
      _enabled = false;
    }
    else{

      email_field.text = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_CHECK_PHONE_GLOBAL);
      _enabled = true;
    }

  }

  void getStoreData() async {

     myPrefs = await SharedPreferences.getInstance();


    if(email_field.text.toString() == "")
    {
      Fluttertoast.showToast(
          msg: "Please enter required field",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
    }
    else {
      myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Second_PHONE,
          email_field.text);

      _navigateToNextScreen(context);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStore();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            SingleChildScrollView(
child: new Form(
        key: _key,
        autovalidate: _validate,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              padding:  EdgeInsets.fromLTRB(10, 0, 15, 0),
                              color: Color.fromRGBO(241, 123, 72, 1),
                              height: 73,
                              child:Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[

                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back_ios,color: Colors.white)
                                    ),

                                    Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child:  LinearPercentIndicator(
                                        width: 210,
                                        animation: true,
                                        lineHeight: 20.0,
                                        animationDuration: 2000,
                                        percent: 0.4,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.help,color: Colors.white,)

                                  ],
                                ),

                              )),


                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 28, 23, 0),
                                child:
                                Text("Phone*",
                                  style: TextStyle(color:Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: TextFormField(
                                controller: email_field,
                                enabled: _enabled,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 14.0,

                                ),
                                cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                                decoration: InputDecoration(
                                  hintText: 'Phone',

                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),),

                              ))
                          ,

                          ]),



                  ],)))),
      bottomNavigationBar: new Container(
        child: Container(

          color: Color.fromRGBO(241, 123, 72, 1),
          height: 52,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  onPressed: (){
                    if(_key.currentState.validate()){
                      getStoreData();
                    }
                    else{
                      // validation error
                      setState(() {
                        _validate = true;
                        Fluttertoast.showToast(
                            msg: "Please Enter Valid Phone number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1
                        );
                      });
                    }

                  },
                  child: Row(

                    children: <Widget>[
                      Row(

                        children: <Widget>[
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[


                                ],)
                          ),
                        ],),


                    ],
                  ),
                ),),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: FractionalOffset.center,
                            child:FlatButton(
                                onPressed: () {
                                  if(_key.currentState.validate()){
                                    getStoreData();
                                  }
                                  else{
                                    // validation error
                                    setState(() {
                                      _validate = true;
                                      Fluttertoast.showToast(
                                          msg: "Please Enter Valid Email Id",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                      );
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Next",style: TextStyle(color: Colors.white,fontSize: 16)),
                                    Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                  ],)
                            ),),
                        ],),


                    ],
                  ),
                ),),

            ],),
        ),
      ),


    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonalInformationThird()),
    );
  }
  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }
}