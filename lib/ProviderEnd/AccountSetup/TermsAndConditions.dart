import 'package:click_a_clean/ProviderEnd/AccountSetup/AccountSetupMain.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TermsAndConditions();
  }
}
class _TermsAndConditions extends State<TermsAndConditions> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            SingleChildScrollView(


                    child:Column(
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
                                        percent: 1.0,

                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.help,color: Colors.white,)

                                  ],
                                ),

                              )),

                          Align(
                            alignment: Alignment.center,
                            child:Padding(
                                padding:  EdgeInsets.fromLTRB(23, 14, 19, 0),
                                child:
                                Text("Personal Data and T&Cs",
                                  style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 18,fontWeight: FontWeight.bold),)
                            ),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 12, 23, 0),
                                child:
                                Text("How we use your personal information",
                                  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14,fontWeight: FontWeight.bold),)
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 5, 23, 0),
                                child:
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 8, 23, 0),
                                child:
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 14, 23, 0),
                                child:
                                Text("You agree to our End user License Agreement",
                                  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12,fontWeight: FontWeight.bold),)
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 5, 23, 0),
                                child:
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                            ),
                          ),
                          Padding(
                         padding:  EdgeInsets.fromLTRB(10, 46, 0, 0),
                          child:Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Checkbox(
                                checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                focusColor: Color.fromRGBO(241, 123, 72, 1),
                                activeColor: Colors.white,
                                hoverColor: Color.fromRGBO(96, 96, 96, 1),
                                value: monVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    monVal = value;
                                  });
                                },
                              ),
                              Container(
                                  padding:  EdgeInsets.fromLTRB(0, 5, 23, 0),
                                  child:
                                  Text("I have read and understood your Privacy \nPolicy and I confirm that I have read and\nunderstood your"
                                      "End User Licence Agreement\nand that I agree to it's terms and conditions.",
                                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                              ),
                            ],
                          )
              )
                    ,
              Align(
                alignment: Alignment.center,
                          child:Container(
                              height: 60,
                              width: 250,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              margin:  EdgeInsets.fromLTRB(0, 30, 0, 0),

                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                textColor: Colors.white,
                                color: Color.fromRGBO(241, 123, 72, 1),
                                child: Text('COMPLETE',style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,)),
                                onPressed: () {
                                  _navigateToNextScreen(context);
                                },
                              )),),

                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSetupMAIN()),
    );
  }

}