
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_first.dart';
import 'package:click_a_clean/UserEnd/ImagePickerExample.dart';
import 'package:click_a_clean/UserEnd/ImagePickerScreen.dart';
import 'package:click_a_clean/UserEnd/NotificationHistory/UserNotificationHistory.dart';
import 'package:click_a_clean/UserEnd/ServiceType/car_velter.dart';
import 'package:click_a_clean/UserEnd/ServiceType/domestic_clean.dart';
import 'package:click_a_clean/UserEnd/camera_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class HomeMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeMenu();
  }
}
class _HomeMenu extends State<HomeMenu> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
   String USER_API_KEY;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),
        body: Padding(
            padding: EdgeInsets.all(0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/home_option.png'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[

                          Container(
                            height: 49,
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            margin:  EdgeInsets.fromLTRB(0, 35, 0, 0),


                            child: Container(
                              child:
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Text("text",style: TextStyle(color: Colors.transparent, fontSize: 16),),
                                    Text("Please Select Your Service",style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Color.fromRGBO(96, 96, 96, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                    IconButton(icon: Icon(Icons.notifications_none,color:  Color.fromRGBO(241, 123, 72, 1)) , onPressed: (){
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                          builder: (context) => UserNotificationHistory(), maintainState: false));

                                    })
                                    //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),

                                  ],
                                ),),

                            ),


                          ),

                          Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 33, 0, 0),
                              child:
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Domestic \n Cleaner',textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Color.fromRGBO(125, 121, 204, 1),
                                          fontSize: 30),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(125, 121, 204, 1),
                                      child: Text('Click Here'),
                                      onPressed: () async {
                                        print(nameController.text);



                                        ///////////////

                                        // ==================== working api ====================

                                        var client = new http.Client();
                                        try {
                                          var response = await client.post(
                                              APPURLS_USER
                                                  .POST_USER_SERVICE_CHOOSE,

                                              headers: {
                                                "x-api-key": USER_API_KEY
                                              },
                                              body: {
                                                'service_id': "1",
                                              }

                                          );


                                          if (response.statusCode == 200) {
                                            //enter your code

                                            print("Response status: ${response
                                                .statusCode}");
                                            print("Response body: ${response
                                                .body}");

                                            SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                            myPrefs.setString(STORE_PREFS.USER_SERVICE_TYPE,"1");
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                builder: (context) => DomesticCleaner(), maintainState: true));
//                                            Navigator.of(
//                                                context, rootNavigator: true)
//                                                .push(MaterialPageRoute(
//                                                builder: (context) =>
//                                                    DomesticCleaner(),
//                                                maintainState: false));

                                            final jsonData = json.decode(
                                                response.body);
                                            if (jsonData["status"] == "true") {
                                              SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                              myPrefs.setString(STORE_PREFS.USER_SERVICE_TYPE,"1");
                                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                  builder: (context) => DomesticCleaner(), maintainState: true));
                                            }


                                          }
                                          else {
                                            Fluttertoast.showToast(
                                                msg: "Something error occured",
                                                toastLength: Toast
                                                    .LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIos: 1
                                            );
                                          }
                                        } on Exception catch (err) {
                                          print("Error : $err");
                                        }
                                      })




                                  ])
                          ),


                        ],
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(10, 60, 0, 0),
                          child:
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Car \nValeter',textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color.fromRGBO(241, 123, 72 ,1),

                                      fontSize: 30),
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(241, 123, 72 ,1),
                                  child: Text('Click Here'),
                                  onPressed: () async {
                                    //print(nameController.text);



                                    // ==================== working api ====================

                                    var client = new http.Client();
                                    try {
                                      var response = await client.post(
                                          APPURLS_USER
                                              .POST_USER_SERVICE_CHOOSE,

                                          headers: {
                                            "x-api-key": USER_API_KEY.toString()
                                          },
                                          body: {
                                            'service_id': "2",
                                          }

                                      );


                                      if (response.statusCode == 200) {
                                        //enter your code

                                        print("Response status: ${response
                                            .statusCode}");
                                        print("Response body: ${response
                                            .body}");
                                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                            builder: (context) => CarVelter(), maintainState: true));

                                        SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                        myPrefs.setString(STORE_PREFS.USER_SERVICE_TYPE,"2");

                                        final jsonData = json.decode(
                                            response.body);
                                        if (jsonData["status"] == "true") {
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (context) => CarVelter(), maintainState: false));

                                          SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                          myPrefs.setString(STORE_PREFS.USER_SERVICE_TYPE,"2");
                                        }


                                      }
                                      else {
                                        Fluttertoast.showToast(
                                            msg: "Something error occured",
                                            toastLength: Toast
                                                .LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIos: 1
                                        );
                                      }
                                    } on Exception catch (err) {
                                      print("Error : $err");
                                    }
                                  })


                              ])
                      ),
                      Container(
                        height: 0,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        margin:  EdgeInsets.fromLTRB(0, 100, 10, 0),

                      ),


                    ]))));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreData();
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonalInformationFirst()),
    );
  }

  getStoreData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
     USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    print("=====check store ==="+USER_API_KEY.toString());}


}