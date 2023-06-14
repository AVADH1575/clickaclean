import 'package:click_a_clean/ProviderEnd/AccountSetup/Home/Provider_home_menu_fragment.dart';
import 'package:click_a_clean/TimeAgoClass/TimeAgo.dart';
import 'package:flutter/material.dart';


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


class NewLeadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLeadScreen();
  }
}
class _NewLeadScreen extends State<NewLeadScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;
  List Booking_Detail_List;
  Map Date_data;
  List Date_data_list;
  String type = "";

  SharedPreferences myPrefs;

  String PROVIDER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe;
  String booking_price_car = "";
  List Time_data_list;
  Map TimeData;
  String Service_type = "";
  int _selectedIndex;
  String Time_ago_string;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;

    });
  }
  _onSelected1(int index) {

    setState(() {
      _selectedIndex = index;
      PostAccept_Api(Time_data_list[index]['id'].toString(),"Accept");

    });
  }
  _onSelected2(int index) {

    setState(() {

      _selectedIndex = index;
      PostAccept_Api(Time_data_list[index]['id'].toString(),"Cancel");

    });
  }

  Future getNotificationData() async {
    myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_NEW_LEADS_HISTORY_URL+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE).toString(), headers: {
      'x-api-key': PROVIDER_API_KEY,
    });


    TimeData = json.decode(response.body);
    setState(() {
      Time_data_list = TimeData["data"];

      print("========newlead==="+Time_data_list.toString());

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

  Future PostAccept_Api(String id,String status) async {
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);


    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_ACCEPT_DECLINE_URL,
          headers: {"x-api-key": PROVIDER_API_KEY
          },
          body: {
            'id': id,
            'status' : status
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {
            if(status == "Accept"){
              Fluttertoast.showToast(
                  msg: "Job Accepted Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1
              );
              _navigateToScreen(context);
            }else{
              Fluttertoast.showToast(
                  msg: "Job Declined Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1
              );
            }


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
          appBar: AppBar(title: Text("New Leads"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),centerTitle: true,),
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
                              TimeAgo.timeAgoSinceDate(Time_data_list[index]["createDate"]);

                              Time_ago_string =  TimeAgo.timeAgoSinceDate(Time_data_list[index]["createDate"]);
                              if(Time_data_list[index]["service_type"] == "1"){
                                Service_type = "Domestic Cleaner";
                              }else{
                                Service_type = "Car Velter";
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
                                    padding: EdgeInsets.only(bottom: 0),
                               margin: EdgeInsets.only(bottom: 2,top: 4,right: 4,left: 4),
                               child:Card(

                                    child:
                                        Column( mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(

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
                                                      Color.fromRGBO(112, 112, 112, 1),
                                                      ),
                                                      ),
                                                    ),

                                                    Container(

                                                      margin: EdgeInsets.fromLTRB(20, 3, 0, 0),
                                                      child: Text(
                                                          Service_type,textAlign: TextAlign.start,style: TextStyle(
                                                        fontSize: 14, color:
                                                       Color.fromRGBO(112, 112, 112, 1),)
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ]),

                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[


                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                child:Text("Order id: #"+"${Time_data_list[index]["id"]}",style: TextStyle(
                                                  fontSize: 14, color:
                                                Color.fromRGBO(112, 112, 112, 1),
                                                ),),
                                              ),
                                            ]),

                                      ],
                                    ),
                                            Row(

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
                                                                fontSize: 15, color:
                                                               Color.fromRGBO(112, 112, 112, 1),
                                                              ),
                                                              ),
                                                            ),

                                                            Container(
                                                              width: 220,
                                                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                              child: Text(
                                                                  "${Time_data_list[index]["address"]}",textAlign: TextAlign.start,style: TextStyle(
                                                                fontSize: 11, color:
                                                              Color.fromRGBO(112, 112, 112, 1),)
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                    ]),

                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[


                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                        child:Text(Time_ago_string,style: TextStyle(
                                                          fontSize: 10, color:
                                                        Color.fromRGBO(112, 112, 112, 1)
                                                        ),),
                                                      ),
                                                    ]),

                                              ],
                                            ),
                                           Padding(
                                             padding: EdgeInsets.only(top: 10),
                                           child: Divider(height: 1,color: Colors.grey,),),
                                            Row(

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

                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                    ]),

                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[

                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),


                                                      ),
                                                      Container(
                                                        height: 26,
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                        child:FlatButton(

                                                          color: Colors.green,
                                                        child:Text("Accept",style: TextStyle(
                                                          fontSize: 14, color:
                                                         Colors.white,
                                                        ),),

                                                          onPressed: (){
                                                           _onSelected1(index);
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 26,
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                        padding: EdgeInsets.fromLTRB(5, 3, 8, 0),
                                                        child:FlatButton(
                                                          color: Colors.red,
                                                          child:Text("Decline",style: TextStyle(
                                                            fontSize: 14, color:
                                                          Colors.white,
                                                          ),),

                                                          onPressed: (){
                                                            _onSelected2(index);
                                                          },
                                                        ),
                                                      ),
                                                    ]),

                                              ],
                                            ),


                                    ]))



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
  void _navigateToScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderHomeMenu()),
    );
  }
  void _navigateToRescheduleScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Reschdule()),
    );
  }

}