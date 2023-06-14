import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/booking_history.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/home_menu_fragment.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/time.dart';
import 'package:click_a_clean/UserEnd/walk_through/choose_user.dart';
import 'package:click_a_clean/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_widget.dart';


import 'package:http/http.dart' as http;

import 'dart:convert';

class Reschdule extends StatefulWidget {

  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
  return _Reschdule();
  }
  }

  class _Reschdule extends State<Reschdule> {


  List Date_data_list;
  String USER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe;
  String booking_price_car = "";
  List Time_data_list;
  Map TimeData;
  Map Date_data;
  SharedPreferences myPrefs;

  Future<dynamic> getData() async {
     myPrefs = await SharedPreferences.getInstance();

    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_DATE_GET, headers: {
      'x-api-key': USER_API_KEY,
    });

    Date_data = json.decode(response.body);
    setState(() {
      Date_data_list = Date_data["data"];

    });



  }
  Future getTimeData() async {
     myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_TIME_GET, headers: {
      'x-api-key': USER_API_KEY,
    });


    TimeData = json.decode(response.body);
    setState(() {
      Time_data_list = TimeData["data"];

    });

  }
  int _selectedIndex,_selected_Index_second,_selected_index_third;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
      myPrefs.setString(STORE_PREFS.USER_BOOKING_DATE, Date_data_list[index]['Week'].toString() + ", " + Date_data_list[index]['date'].toString() + " "+Date_data_list[index]['Month'].toString() + " "+Date_data_list[index]['Year'].toString());

    });
  }
  _onSelected_third(int index) {

    setState(() {
      _selected_index_third = index;
    });
  }
  _onSelected_second(int index) {

    setState(() {
      _selected_Index_second = index;
      myPrefs.setString(STORE_PREFS.USER_BOOKING_TIME,Time_data_list[index]['timebook'].toString());

    });
  }
  Future PostDelete_Notification() async {
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);


    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_RESCHEDULE_URL,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'id': myPrefs.getString(STORE_PREFS.USER_ACTIVE_BOOKING_ID),
            'userDate': myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE),
            'userTime': myPrefs.getString(STORE_PREFS.USER_BOOKING_TIME),
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            Fluttertoast.showToast(msg: jsonData["message"].toString());

            myPrefs.setString(STORE_PREFS.USER_BOOKING_TIME,"null");
            myPrefs.setString(STORE_PREFS.USER_BOOKING_DATE,"null");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));

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
    getData();
    getTimeData();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text('Car Clean'),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
       child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
                 Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Center(
                  child: Text(
                      'When would you like your services?',
                      style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                      textAlign: TextAlign.center
                  ),
                ),),
              new Container(
                height: 60,

                ////////
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    shrinkWrap: true,
                    itemCount: Date_data_list == null ? 0 : Date_data_list.length,
                    itemBuilder: (BuildContext context, int index) {

                      return GestureDetector(

                        onTap: () {
                          setState(() {
                            _onSelected(index);


                          });

                          print("${Date_data_list[index]['id'].toString()}");

                        },
                        child:
                        Container(

                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          decoration: BoxDecoration(
                            color:   Colors.white,
                            border: Border.all(
                              color:  _selectedIndex != null && _selectedIndex == index
                                  ? Color.fromRGBO(125, 121, 204, 1)
                                  : Color.fromRGBO(112, 112, 112, 1),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:FlatButton(


                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Container(

                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      Container(
                                        alignment: FractionalOffset.center,
                                        child: Text(
                                          "${Date_data_list[index]["Week"]}",textAlign: TextAlign.center,style: TextStyle(
                                          fontSize: 11, color:
                                        _selectedIndex != null && _selectedIndex == index
                                            ? Color.fromRGBO(125, 121, 204, 1)
                                            : Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                        ),
                                      ),

                                      Container(
                                        alignment: FractionalOffset.center,

                                        child: Text(
                                            "${Date_data_list[index]["date"]}",textAlign: TextAlign.center,style: TextStyle(
                                          fontSize: 13, color:
                                        _selectedIndex != null && _selectedIndex == index
                                            ? Color.fromRGBO(125, 121, 204, 1)
                                            : Color.fromRGBO(112, 112, 112, 1),)
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),),
                          width: 60.0,
                          height: 70.0,
                        ),

                      );

                    }

                ),
              ),
              new Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Center(
                  child: Text(
                      'At what time should the professional\n arrive?',
                      style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                      textAlign: TextAlign.center
                  ),
                ),
              ),

              new GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: Time_data_list == null ? 0 : Time_data_list.length,

                padding: const EdgeInsets.only(left:20.0,right: 20,top: 10),

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 6),

                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(

                    onTap: () {
                      setState(()  {
                        _onSelected_second(index);


                      });

                      print("${Time_data_list[index]['id'].toString()}");
                    },
                    child:Container(
                      width: 60.0,
                      height: 70.0,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                        color:  _selected_Index_second != null && _selected_Index_second == index
                            ?  Color.fromRGBO(250, 250, 250, 1)
                            : Colors.white,
                        border: Border.all(
                          color:  _selected_Index_second != null && _selected_Index_second == index
                              ? Color.fromRGBO(125, 121, 204, 1)
                              : Color.fromRGBO(112, 112, 112, 1),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),


                      child:FlatButton(

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: <Widget>[
                                  Container(
                                    alignment: FractionalOffset.center,
                                    child: Text(
                                      "${Time_data_list[index]["timebook"]}",textAlign: TextAlign.center,style: TextStyle(
                                      fontSize: 13,color:
                                    _selected_Index_second != null && _selected_Index_second == index
                                        ? Color.fromRGBO(125, 121, 204, 1)
                                        : Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),),
                    ),
                  );

                },
              ),
              new Container(

                padding: EdgeInsets.only(top:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,

                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromRGBO(241, 123, 72, 1),
                              ),
                              child: FlatButton(
                                child: Column(
                                  children: <Widget>[
                                    Container(

                                      padding: EdgeInsets.only(top: 13.5),
                                      child: Text(
                                        'CANCEL',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                      ),
                                    )
                                  ],
                                ),onPressed: (){
                                  Navigator.pop(context);
                              },
                              ),
                            ),
                          )
                        ],
                      ),
                      width: 140.0,
                      height: 40.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,

                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromRGBO(125, 121, 204, 1),
                              ),
                              child: FlatButton(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 13.5),
                                      child: Text(
                                        'RESCHEDULE',style: TextStyle(
                                        fontSize: 13,color: Colors.white
                                      ),
                                      ),
                                    )
                                  ],
                                ),
                              onPressed: (){
                                  if (myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE) == "null" || myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE) == "" || myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE) == null){
                                    Fluttertoast.showToast(msg: "Please choose first date and time");
                                  }
                                  else {
                                    PostDelete_Notification();
                                  }
                                
                              },),
                            ),
                          )
                        ],
                      ),
                      width: 130.0,
                      height: 40.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                       // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),

                  ],
                ),
              )

            ],),

        ],

      ),),

    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Time()),
    );
  }
  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen_Fragment()),
    );
  }
}