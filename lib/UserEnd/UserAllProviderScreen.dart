import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/paymentSucess.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAllProviderScreen extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _UserAllProviderScreen();
  }
}

class _UserAllProviderScreen extends State<UserAllProviderScreen> {
  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;

  Map JOB_TYPE_data;
  List JOB_TYPE_LIST_DATA;
  List Booking_Detail_List;
  Map Date_data;
  List Date_data_list;

  SharedPreferences myPrefs;

  String USER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe,job_id;
  String work_status = "Confirm";
  String booking_price_car = "";
  List Time_data_list;
  Map TimeData;


  int _selectedIndex;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
      getDataJOBID(Time_data_list[index]['id'].toString());
    });
  }
  Future getDataServiceName() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_CHECK_SERVICE_NAME, headers: {
      'x-api-key': USER_API_KEY,
    });

    SERVICE_TYPE_data = json.decode(response.body);
    setState(() {
      sERVICE_TYPE_LIST_DATA = SERVICE_TYPE_data["data"];

      service_name = sERVICE_TYPE_LIST_DATA[0]["servicename"].toString();

    });

  }

  Future getDataJOBID(String provider_id) async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_JOB_ID_BOOKING, headers: {
      'x-api-key': USER_API_KEY,
    });

    JOB_TYPE_data = json.decode(response.body);
    setState(() {
      JOB_TYPE_LIST_DATA = JOB_TYPE_data["data"];
      print("======jobid===="+JOB_TYPE_LIST_DATA.toString());
      job_id = JOB_TYPE_LIST_DATA[0]["id"].toString();

      PostDelete_Notification(provider_id,job_id);

    });

  }


  Future getNotificationData() async {
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_ALL_PROVIDER, headers: {
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
  Future PostDelete_Notification(String id,String job_id) async {
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    print("==========id===="+id);
    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_BookingConfirm_URL,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'provider_id': id,
            'id' : job_id
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("==========Response status: ${response.statusCode}");
        print("=======Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {


            Fluttertoast.showToast(
                msg: jsonData["message"].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );
         _navigateToNextScreen(context);

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
    getDataServiceName();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromRGBO(125, 121, 204, 1),
              title: Text("Choose Service Provider"),
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
                            physics: ScrollPhysics(),
                            shrinkWrap: true,

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
                                                    'assets/images/avatar_bg.png',

                                                     fit: BoxFit.fill,
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
                                                          "${Time_data_list[index]["provider_Firstname"]}",textAlign: TextAlign.start,style: TextStyle(
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
                                                            service_name!=null?service_name: "",textAlign: TextAlign.start,style: TextStyle(
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
                                                color: Color.fromRGBO(125, 121, 204, 1),
                                                onPressed: (){
                                                  _onSelected(index);

                                                 // _navigateToNextScreen(context);
                                                },

                                                child: Text("Confirm",style: TextStyle(color: Colors.white),),)),

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
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentSucess()),
    );
  }
}