import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyIdentyFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyIdentyFirst();
  }
}
class _VerifyIdentyFirst extends State<VerifyIdentyFirst> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify your identity"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 41, 23, 0),
                                child:
                                Text("We need to see your ID and a picture \nof your face.",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 41, 23, 0),
                                child:
                                Text("This is to:",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 31, 0, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                   // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                    Icon(Icons.check,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                      child:
                                      Text("Authenticate your ID",
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          )
                          ,

                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 19, 0, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                  Icon(Icons.check,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                      child:
                                      Text("Match your ID to your face",
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 19, 0, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                  Icon(Icons.check,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                      child:
                                      Text("Comply with regulations",
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          )
                        ]),

                    Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin:  EdgeInsets.fromLTRB(34, 0, 34, 69),

                        child: RaisedButton(

                          child: Container(
                            child:

                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                   Text('COMPLETE',style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,)),
                                    //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),

//                           Column(
//                               children: <Widget>[
//                            FlatButton(
//                              onPressed: () {},
//                              child:Icon(Icons.play_circle_filled,color: Color.fromRGBO(241, 123, 72, 1),)
//                            )],)
                                ],
                              ),

                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textColor: Colors.white,
                          color: Color.fromRGBO(241, 123, 72, 1),
                          splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                          onPressed: () {
                            _navigateToNextScreen(context);
                          },
                        )),


                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyIdentySecond()),
    );
  }

}