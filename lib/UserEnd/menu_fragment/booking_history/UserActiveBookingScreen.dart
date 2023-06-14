import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/AddLocation/TrackOrder.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/reschdule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserActiveBookingScreen extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _UserActiveBookingScreen();
  }
}

class _UserActiveBookingScreen extends State<UserActiveBookingScreen> {
  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;
  List Booking_Detail_List;
  Map Date_data;
  List Date_data_list;
  String type = "";

  SharedPreferences myPrefs;

  String USER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe;
  String booking_price_car = "";
  List Time_data_list;
  Map TimeData;

  int _selectedIndex;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
      PostDelete_Notification(Time_data_list[index]['id'].toString());
    });
  }
  _onSelected1(int index) {

    setState(() {
      _selectedIndex = index;

      myPrefs.setString(STORE_PREFS.USER_ACTIVE_BOOKING_ID,Time_data_list[index]['id'].toString());

      Navigator.of(
          context, rootNavigator: true)
          .push(MaterialPageRoute(
          builder: (context) =>
              TrackOrder(),
          maintainState: false));

    });
  }
  _onSelected2(int index) {

    setState(() {
      myPrefs.setString(STORE_PREFS.USER_ACTIVE_BOOKING_ID,Time_data_list[index]['id'].toString());

      _selectedIndex = index;
      Navigator.of(
          context, rootNavigator: true)
          .push(MaterialPageRoute(
          builder: (context) =>
              Reschdule(),
          maintainState: true));

    });
  }

  Future getNotificationData() async {
   myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_ACTIVE_BOOKING_LIST_API, headers: {
      'x-api-key': USER_API_KEY,
    });


    TimeData = json.decode(response.body);
    setState(() {
      Time_data_list = TimeData["data"];
      if (Time_data_list.length.toString() == "0")
      {

        Fluttertoast.showToast(
            msg: "No data found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1
        );
      }


    });

  }

  Future PostDelete_Notification(String id) async {
     myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);


    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_USER.GET_USER_ACTIVE_CANCEL_BOOKING,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'id': id,
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            Fluttertoast.showToast(
                msg: jsonData["message"].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );

            getNotificationData();


          }

          else {
            Fluttertoast.showToast(msg: jsonData["message"].toString());
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationData();


  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(

          body: SingleChildScrollView(

              child:Column(

                children: <Widget>[
                  Column(
                    children: <Widget>[

                      Container(

                        ////////
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,

                            itemCount: Time_data_list == null ? 0 : Time_data_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              if(Time_data_list[index]["service_type"] == "2"){
                                type = "Car Valeter";

                              }
                              else {
                                type = "Domestic Cleaner";

                              }
                              return GestureDetector(

                                  onTap: () {
                                    setState(() {


                                      //   myPrefs.setString(STORE_PREFS.USER_BOOKING_DATE, Date_data_list[index]['Week'].toString() + ", " + Date_data_list[index]['date'].toString() + " "+Date_data_list[index]['Month'].toString() + " "+Date_data_list[index]['Year'].toString());

                                    });

                                    //     print("${Date_data_list[index]['id'].toString()}");

                                  },


                                  child:

                                  Container(

                                    color: Colors.white,
                                    padding: EdgeInsets.only(bottom: 5),
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[

                                                Container(

                                                  alignment: FractionalOffset.topLeft,

                                                  child: Column(

                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

                                                        child: Text(

                                                          type,textAlign: TextAlign.start,style: TextStyle(
                                                          fontSize: 14, color:
                                                        _selectedIndex != null && _selectedIndex == index
                                                            ? Color.fromRGBO(125, 121, 204, 1)
                                                            : Color.fromRGBO(112, 112, 112, 1),
                                                        ),
                                                        ),
                                                      ),

                                                      Container(

                                                        margin: EdgeInsets.fromLTRB(20, 3, 0, 0),
                                                        child: Text(
                                                            "${Time_data_list[index]["userDate"]}" + " at " + "${Time_data_list[index]["userTime"]}",textAlign: TextAlign.start,style: TextStyle(
                                                          fontSize: 11, color:
                                                        _selectedIndex != null && _selectedIndex == index
                                                            ? Color.fromRGBO(125, 121, 204, 1)
                                                            : Color.fromRGBO(112, 112, 112, 1),)
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                              ]),
//                                          Container(
//                                            width: 200,
//                                            child: Row(
//                                              crossAxisAlignment: CrossAxisAlignment.start,
//                                              mainAxisAlignment: MainAxisAlignment.start,
//                                              children: <Widget>[
//                                            Row(
//
//                                            children: <Widget>[
//                                            FlatButton(
//                                                onPressed: (){
//                                                  _onSelected(index);
//                                                },
//
//                                                child:Image.asset(
//                                                  'assets/images/cancel_btn.png',
//
//                                                  // fit: BoxFit.contain,
//                                                  height: 25,
//                                                  width: 25,
//
//
//                                                ),),
//                                                FlatButton(
//                                                  onPressed: (){
//                                                    _onSelected(index);
//                                                  },
//
//                                                  child:Image.asset(
//                                                    'assets/images/cancel_btn.png',
//
//                                                    // fit: BoxFit.contain,
//                                                    height: 25,
//                                                    width: 25,
//
//
//                                                  ),),
//                                                FlatButton(
//                                                  onPressed: (){
//                                                    _onSelected(index);
//                                                  },
//
//                                                  child:Image.asset(
//                                                    'assets/images/cancel_btn.png',
//
//                                                    // fit: BoxFit.contain,
//                                                    height: 25,
//                                                    width: 25,
//
//
//                                                  ),),])
////                                                Column(
////
////
////                                                  child: Text(
////
////
////                                                    type,textAlign: TextAlign.start,style: TextStyle(
////                                                    fontSize: 14, color:
////                                                  _selectedIndex != null && _selectedIndex == index
////                                                      ? Color.fromRGBO(125, 121, 204, 1)
////                                                      : Color.fromRGBO(112, 112, 112, 1),
////                                                  ),
////                                                  ),
////                                                ),
//
//
//                                              ],
//                                            ),
//
////                                              child: FlatButton(
////                                                onPressed: (){
////                                                  _onSelected(index);
////                                                },
////
////                                                child:Image.asset(
////                                                  'assets/images/cancel_btn.png',
////
////                                                  // fit: BoxFit.contain,
////                                                  height: 25,
////                                                  width: 25,
////
////
////                                                ),)
//
//
//                                          ),

                                          Row(
crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[

                                                Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child:
                                                    IconButton(icon: Icon(Icons.location_on,color: Colors.black,),
                                                    onPressed: (){
                                                      _onSelected1(index);
                                                    },),

                              ),
                                                Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child:IconButton(icon: Icon(Icons.restore,color: Colors.black,),

                                                    onPressed: (){
                                                      _onSelected2(index);
                                                    },
                                                  ),
                                                 ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                  child:IconButton(icon: Icon(Icons.cancel,color: Colors.black,),
                                                  onPressed: (){
                                                    _onSelected(index);
                                                  },),
                                                ),
                                              ]),

                                        ],
                                      ),



                                  )

                              );

                            }

                        ),
                      ),

                    ],),



                ],

              )),



        ));
  }
  void _navigateToAddressListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackOrder()),
    );
  }
  void _navigateToRescheduleScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Reschdule()),
    );
  }

}