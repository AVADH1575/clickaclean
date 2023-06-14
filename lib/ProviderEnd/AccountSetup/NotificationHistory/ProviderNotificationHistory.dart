import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderNotificationHistory extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _ProviderNotificationHistory();
  }
}

class _ProviderNotificationHistory extends State<ProviderNotificationHistory> {
  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;
  List Booking_Detail_List;
  Map Date_data;
  List Date_data_list;

  SharedPreferences myPrefs;

  String PROVIDER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe;
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

  Future getNotificationData() async {
    myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_NOTIFICATION_LIST_URL, headers: {
      'x-api-key': PROVIDER_API_KEY,
    });


    TimeData = json.decode(response.body);
    setState(() {
      Time_data_list = TimeData["data"];
      print("=====Provider_notification_history===="+Time_data_list.toString());
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

    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);


    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_NOTIFICATION_DELETE_URL,
          headers: {"x-api-key": PROVIDER_API_KEY
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
          appBar: AppBar(
              backgroundColor: Color.fromRGBO(241, 123, 72, 1),
              title: Text("Notification"),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),    onPressed: () => Navigator.of(context).pop(),)
          ),
          body: SingleChildScrollView(

              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[

                      Container(

                        ////////
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,

                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: Time_data_list == null ? 0 : Time_data_list.length,
                            itemBuilder: (BuildContext context, int index) {

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
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    margin: EdgeInsets.only(bottom: 3),
                                    child:FlatButton(


                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
                                                  child: Image.asset(
                                                    'assets/images/noti.png',

                                                    // fit: BoxFit.contain,
                                                    height: 40,
                                                    width: 40,


                                                  ),),
                                                Container(

                                                  alignment: FractionalOffset.topLeft,

                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
                                                        width: 180,

                                                        child: Text(
                                                          "${Time_data_list[index]["message"]}",textAlign: TextAlign.start,style: TextStyle(
                                                          fontSize: 12, color:
                                                        _selectedIndex != null && _selectedIndex == index
                                                            ? Color.fromRGBO(125, 121, 204, 1)
                                                            : Color.fromRGBO(112, 112, 112, 1),
                                                        ),
                                                        ),
                                                      ),

                                                      Container(

                                                        margin: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                                        child: Text(
                                                            "${Time_data_list[index]["userDate"]}" + " at " +  "${Time_data_list[index]["userTime"]}",textAlign: TextAlign.start,style: TextStyle(
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
                                          Container(


                                              child: FlatButton(
                                                onPressed: (){
                                                  _onSelected(index);
                                                },

                                                child:Image.asset(
                                                  'assets/images/delete_icon.png',

                                                  // fit: BoxFit.contain,
                                                  height: 25,
                                                  width: 25,


                                                ),)),

                                        ],
                                      ),




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

}