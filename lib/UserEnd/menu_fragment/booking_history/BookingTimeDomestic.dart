import 'dart:io';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ApiHit/SharedPrefs/SharedPrefers.dart';
import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../time.dart';
import 'dart:convert';


class BookingTimeDomestic extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _BookingTimeDomesticState();
  }
}

class _BookingTimeDomesticState extends State<BookingTimeDomestic> {
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;

  bool pressAttention5 = false;
  bool pressAttention6 = false;
  bool pressAttention7 = false;
  bool pressAttention8 = false;
  bool pressAttention9 = false;
  bool pressAttention10 = false;
  bool pressAttention11 = false;
  bool pressAttention12 = false;
  bool pressAttention13 = false;

  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;

  Map Date_data;
  List Date_data_list;
  Map Hours_data;
  List Hours_data_list;
  SharedPreferences myPrefs;

  String USER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe,USER_BOOKING_HOUR_;
  List Time_data_list;
  Map TimeData;
  String booking_price = "";
  bool viewVisible = false ;

  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  Future<dynamic> getData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_DATE_GET, headers: {
      'x-api-key': USER_API_KEY,
    });

    Date_data = json.decode(response.body);
    setState(() {
      Date_data_list = Date_data["data"];

    });

  }
  Future<dynamic> getHoursData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_HOUR_GET, headers: {
      'x-api-key': USER_API_KEY,
    });

    Hours_data = json.decode(response.body);
    setState(() {
      Hours_data_list = Hours_data["data"];
      print("======hour_list===="+Hours_data_list.toString());

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

  Future getTimeData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_TIME_GET, headers: {
      'x-api-key': USER_API_KEY,
    });


    TimeData = json.decode(response.body);
    setState(() {
      Time_data_list = TimeData["data"];

    });

  }

  Future post_DOMESTIC_BOOKING(String hour) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_DOMESTIC_BOOKING_API,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'hour': hour,

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price status: ${response.statusCode}");
        print("price body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {


            print("price : ${jsonData["data"][0]["price"]}");
            booking_price = jsonData["data"][0]["price"];
            myPrefs.setString(STORE_PREFS.USER_CAR_VALET_PRICE,booking_price);

          }

          else {
            print("price_ListResponse else: ${response.statusCode}");
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }

  Future post_carvelter_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    USER_CAR_DATe = myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE);
    USER_CAR_TIMe = myPrefs.getString(STORE_PREFS.USER_BOOKING_HOUR);

    USER_BOOKING_HOUR_ = myPrefs.getString(STORE_PREFS.USER_BOOKING_HOUR);
    _navigateToNextScreen(context);
//    var client = new http.Client();
//    try {
//      var response = await client.post(
//          APPURLS_USER.POST_USER_ADD_CAR_DATE_TIME_POST_URL,
//          headers: {"x-api-key": USER_API_KEY
//          },
//          body: {
//            'userDate': USER_CAR_DATe,
//            'userTime':  USER_CAR_TIMe,
//          }
//
//      );
//
//      if (response.statusCode == 200 ) {
//        //enter your code
//
//        print("TIME_DTAE_ListResponse status: ${response.statusCode}");
//        print("TIME_DTAEResponse body: ${response.body}");
//
//        final jsonData = json.decode(response.body);
//
//        setState(() {
//
//          if (jsonData["status"] == true) {
//
//            _navigateToNextScreen(context);
//            print("TIME_DTAE_List : ${jsonData["data"][0]["service"]}");
//
//          }
//
//          else {
//            print("TIME_DTAE_ListResponse else: ${response.statusCode}");
//          }
//        });
//
//      }
//    } on Exception catch (err) {
//      print("Error : $err");
//    }
  }

  Future<String> getDATASTORE() async {
    myPrefs = await SharedPreferences.getInstance();
  }
  int _selectedIndex,_selected_Index_second,_selected_index_third;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }
  _onSelected_third(int index) {

    setState(() {
      _selected_index_third = index;
    });
    post_DOMESTIC_BOOKING(Hours_data_list[index]["hour"]);
  }
  _onSelected_second(int index) {

    setState(() {
      _selected_Index_second = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getTimeData();
    getDataServiceName();
    getDATASTORE();
    getHoursData();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromRGBO(125, 121, 204, 1),
              title: Text(service_name!=null?service_name: ""),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Center(
                          child: Text(
                              'When would you like your services?',
                              style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                              textAlign: TextAlign.center
                          ),
                        ),),


                      Container(
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

                                    myPrefs.setString(STORE_PREFS.USER_BOOKING_DATE, Date_data_list[index]['Week'].toString() + ", " + Date_data_list[index]['date'].toString() + " "+Date_data_list[index]['Month'].toString() + " "+Date_data_list[index]['Year'].toString());

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
                              'Select booking hours required',
                              style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ),
                      Container(
                        height: 60,

                        ////////
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,

                            shrinkWrap: true,
                            itemCount: Hours_data_list == null ? 0 : Hours_data_list.length,
                            itemBuilder: (BuildContext context, int index) {

                              return GestureDetector(

                                onTap: () {
                                  setState(() {
                                    _onSelected_third(index);
                                      print("======hour===check==="+Hours_data_list[index]["hour"].toString());
                                      myPrefs.setString(STORE_PREFS.USER_BOOKING_HOUR,Hours_data_list[index]['hour'].toString());
                                  });

                                  print("${Hours_data_list[index]['id'].toString()}");

                                },
                                child:
                                Container(

                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),

                                  decoration: BoxDecoration(
                                    color:   Colors.white,
                                    border: Border.all(
                                      color:  _selected_index_third != null && _selected_index_third == index
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
                                                  "${Hours_data_list[index]["hour"]}",textAlign: TextAlign.center,style: TextStyle(
                                                  fontSize: 11, color:
                                                _selected_index_third != null && _selected_index_third == index
                                                    ? Color.fromRGBO(125, 121, 204, 1)
                                                    : Color.fromRGBO(112, 112, 112, 1),
                                                ),
                                                ),
                                              ),
                                              Container(
                                                alignment: FractionalOffset.center,

                                                child: Text(
                                                    "Hours",textAlign: TextAlign.center,style: TextStyle(
                                                  fontSize: 12, color:
                                                _selected_index_third != null && _selected_index_third == index
                                                    ? Color.fromRGBO(125, 121, 204, 1)
                                                    : Color.fromRGBO(112, 112, 112, 1),)
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),),
                                  width: 70.0,
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
                              'At what time should the professional arrive?',
                              style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ),
                      new GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: Time_data_list == null ? 0 : Time_data_list.length,

                        padding: const EdgeInsets.only(left:20.0,right: 20,top: 5),

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
                                showWidget();
                                myPrefs.setString(STORE_PREFS.USER_BOOKING_TIME,Time_data_list[index]['timebook'].toString());

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


                    ],),



                ],

              )),
          bottomNavigationBar:

    Visibility(
    visible: viewVisible,
          child:new Container(

            color: Color.fromRGBO(125, 121, 204, 1),
            height: 52,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: FractionalOffset.centerLeft,
                              child:FlatButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text(booking_price != null ? booking_price: "",style: TextStyle(color: Colors.white,fontSize: 16)),
                                    ],)
                              ),),
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
                                    // _navigateToNextScreen(context);
                                    post_carvelter_data();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Continue",style: TextStyle(color: Colors.white,fontSize: 16)),

                                      Icon(
                                          Icons.arrow_forward_ios,color: Colors.white)

                                    ],

                                  )

                              ),),

                          ],),


                      ],
                    ),
                  ),),

              ],),
          ),)


        ));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressList()),
    );
  }
}