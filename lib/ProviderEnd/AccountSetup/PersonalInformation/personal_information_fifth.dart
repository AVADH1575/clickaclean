import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import '../TermsAndConditions.dart';

class PersonalInformationFifth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalInformationFifth();
  }
}
class _PersonalInformationFifth extends State<PersonalInformationFifth> {
  TextEditingController address_field = TextEditingController();
  TextEditingController town_field = TextEditingController();
  TextEditingController state_field = TextEditingController();
  TextEditingController pin_code_field = TextEditingController();


   String value = "";

  Future personal_post_api_hit() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if(address_field.text.toString() == null ||  address_field.text.toString() == "" || pin_code_field.text.toString() == null || pin_code_field.text.toString() == ""
        || state_field.text.toString() == null || state_field.text.toString() == ""|| town_field.text.toString() == null || town_field.text.toString() == ""
    )

    {
      Fluttertoast.showToast(
          msg: "Please enter required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
    }
    else {
      var client = new http.Client();
      try {
        var response = await client.post(
            APPURLS_PROVIDER.POST_PROVIDER_PERSONAL_INFORMATION_URL,
            headers: {
              "x-api-key": myPrefs.getString(
                  STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()
            },
            body: {
              'provider_Firstname': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_FIRST_NAME)
                  .toString(),
              'provider_Lastname': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_LAST_NAME)
                  .toString(),
              'provider_address': address_field.text,
              'provider_email': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PROVIDER_EMAIL_GLOBAL).toString(),
              'provider_pincode': pin_code_field.text,
              'provider_country': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Four_HOME_COUNTRY)
                  .toString(),
              'provider_state': state_field.text,
              'provider_town': town_field.text,
              'provider_dob': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Third_DOB)
                  .toString(),
              'provider_phone': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Second_PHONE)
                  .toString(),
              'provider_Middlename': myPrefs.getString(
                  STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_MIDDLE_NAME)
                  .toString(),

            }

        );

        if (response.statusCode == 200) {
          //enter your code

          print("TIME_DTAE_ListResponse status: ${response.statusCode}");
          print("TIME_DTAEResponse body: ${response.body}");

          final jsonData = json.decode(response.body);

          setState(() {
            if (jsonData["status"] == true) {
              myPrefs.setString(
                  STORE_PREFS_PROVIDER.COMPLETE_PERSONAL_INFORMATION_STATUS,
                  "Complete");
              _navigateToNextScreen(context);
            }

            else {
              print("TIME_DTAE_ListResponse else: ${response.statusCode}");
            }
          });
        }
      } on Exception catch (err) {
        print("Error : $err");
      }
    }
  }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:SingleChildScrollView(

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
                                        percent: 0.9,

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
                                padding:  EdgeInsets.fromLTRB(23, 14, 23, 0),
                                child:
                                Text("Address*",
                                  style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: TextField(
                                controller: address_field,
                                style: TextStyle(
                                  fontSize: 14.0,

                                ),
                                cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                                decoration: InputDecoration(
                                  hintText: 'Address',

                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),),
                                onChanged: (text) {
                                  value = text;
                                },
                              ))
                          ,

                          Align(
                            alignment: Alignment.topLeft,
                            child:Padding(
                                padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                                child:Text('Town*',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: TextField(
                                controller: town_field,
                                style: TextStyle(
                                  fontSize: 14.0,

                                ),

                                cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                                decoration: InputDecoration(

                                  hintText: 'Town',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),),
                                onChanged: (text) {
                                  value = text;
                                },
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child:Padding(
                                padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                                child:Text('State*',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: TextField(
                                controller: state_field,
                                style: TextStyle(
                                  fontSize: 14.0,

                                ),

                                cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                                decoration: InputDecoration(

                                  hintText: 'State',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),),
                                onChanged: (text) {
                                  value = text;
                                },
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child:Padding(
                                padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                                child:Text('Postcode/Zipcode*',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                              child: TextField(
                                controller: pin_code_field,
                                style: TextStyle(
                                  fontSize: 14.0,

                                ),

                                cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                                decoration: InputDecoration(

                                  hintText: 'Postcode/Zipcode',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                                  ),),
                                onChanged: (text) {
                                  value = text;
                                },
                              )),
                        ]),
                  ],))),

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
                    personal_post_api_hit();
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

                                  personal_post_api_hit();
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
      MaterialPageRoute(builder: (context) => TermsAndConditions()),
    );
  }

}