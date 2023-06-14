import 'dart:math';

import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/Payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Time extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _Time();
  }
}

class _Time extends State<Time> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thuVal = false;
  String USER_API_KEY,service_name,USER_SERVICE_TYPe;
  String booking_price, booking_date,booking_time,booking_type,valter_type;
  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;
  String booking_price_car = "";
  String USER_DOMESTIC_BUILDING_TYPES_id = "";
  String USER_DOMESTIC_BUILDING_SIZE_id = "";
  String USER_DOMESTIC_BUILDING_NO_ROOMS_id = "";
  String USER_DOMESTIC_LOVE_PET_id = "";
  String USER_DOMESTIC_USER_BOOKING_TIME = "";
  String USER_DOMESTIC_USER_BOOKING_DATE = "";
  String USER_DOMESTIC_USER_SERVICE_TYPE = "";
  String USER_DOMESTIC_USER_BOOKING_HOUR = "";
  String USER_DOMESTIC_USER_BOOKING_ADDRESS = "";
  String USER_DOMESTIC_USER_BOOKING_FLAT = "";
  String USER_DOMESTIC_USER_BOOKING_ADDRESS_NAME = "";
  String USER_DOMESTIC_USER_BOOKING_PHONE = "";
  String USER_DOMESTIC_USER_BOOKING_INSTRUCTION_CODE = "";
  String USER_DOMESTIC_USER_BOOKING_KEYFILE_NAME = "";
  String USER_DOMESTIC_USER_BOOKING_LAT = "";
  String USER_DOMESTIC_USER_BOOKING_LOG = "";
  String USER_DOMESTIC_USER_BOOKING_SAVED_ADDRESS_TYPE = "";

  String USER_USER_CAR_TYPE_ID = "";
  String USER_USER_CAR_VALET_ID = "";

  List Booking_Detail_List;
  String Car_valter_name,Car_valeter_type,petslove,rooms_size;
  SharedPreferences myPrefs;

  Future getDataServiceName() async {

     myPrefs = await SharedPreferences.getInstance();
     booking_price_car= myPrefs.getString(STORE_PREFS.USER_CAR_VALET_PRICE!=null?STORE_PREFS.USER_CAR_VALET_PRICE: "");

     USER_DOMESTIC_BUILDING_TYPES_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_TYPES_ID!=null?STORE_PREFS.USER_DOMESTIC_BUILDING_TYPES_ID: "");
     USER_DOMESTIC_BUILDING_SIZE_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_SIZE!=null?STORE_PREFS.USER_DOMESTIC_BUILDING_SIZE: "");
     USER_DOMESTIC_BUILDING_NO_ROOMS_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_NO_ROOMS!=null?STORE_PREFS.USER_DOMESTIC_BUILDING_NO_ROOMS: "");
     USER_DOMESTIC_LOVE_PET_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID!=null?STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID: "");

     USER_DOMESTIC_USER_BOOKING_TIME = myPrefs.getString(STORE_PREFS.USER_BOOKING_TIME!=null?STORE_PREFS.USER_BOOKING_TIME: "");
     USER_DOMESTIC_USER_BOOKING_DATE = myPrefs.getString(STORE_PREFS.USER_BOOKING_DATE!=null?STORE_PREFS.USER_BOOKING_DATE: "");
     USER_DOMESTIC_USER_SERVICE_TYPE = myPrefs.getString(STORE_PREFS.USER_SERVICE_TYPE!=null?STORE_PREFS.USER_SERVICE_TYPE: "");
     USER_DOMESTIC_USER_BOOKING_HOUR = myPrefs.getString(STORE_PREFS.USER_BOOKING_HOUR!=null?STORE_PREFS.USER_BOOKING_HOUR: "");

     USER_DOMESTIC_USER_BOOKING_ADDRESS = myPrefs.getString(STORE_PREFS.USER_BOOKING_ADDRESS!=null?STORE_PREFS.USER_BOOKING_ADDRESS: "");
     USER_DOMESTIC_USER_BOOKING_FLAT = myPrefs.getString(STORE_PREFS.USER_BOOKING_FLAT!=null?STORE_PREFS.USER_BOOKING_FLAT: "");
     USER_DOMESTIC_USER_BOOKING_ADDRESS_NAME = myPrefs.getString(STORE_PREFS.USER_BOOKING_ADDRESS_NAME!=null?STORE_PREFS.USER_BOOKING_ADDRESS_NAME: "");
     USER_DOMESTIC_USER_BOOKING_SAVED_ADDRESS_TYPE = myPrefs.getString(STORE_PREFS.USER_BOOKING_SAVED_ADDRESS_TYPE!=null?STORE_PREFS.USER_BOOKING_SAVED_ADDRESS_TYPE: "");
     USER_DOMESTIC_USER_BOOKING_PHONE = myPrefs.getString(STORE_PREFS.USER_BOOKING_PHONE!=null?STORE_PREFS.USER_BOOKING_PHONE: "");

     USER_DOMESTIC_USER_BOOKING_INSTRUCTION_CODE= myPrefs.getString(STORE_PREFS.USER_BOOKING_INSTRUCTION_CODE!=null?STORE_PREFS.USER_BOOKING_INSTRUCTION_CODE: "");
     USER_DOMESTIC_USER_BOOKING_KEYFILE_NAME= myPrefs.getString(STORE_PREFS.USER_BOOKING_KEYFILE_NAME!=null?STORE_PREFS.USER_BOOKING_KEYFILE_NAME: "");
     USER_DOMESTIC_USER_BOOKING_LAT = myPrefs.getString(STORE_PREFS.USER_BOOKING_LAT!=null?STORE_PREFS.USER_BOOKING_LAT: "");
     USER_DOMESTIC_USER_BOOKING_LOG= myPrefs.getString(STORE_PREFS.USER_BOOKING_LOG!=null?STORE_PREFS.USER_BOOKING_LOG: "");

     USER_USER_CAR_TYPE_ID = myPrefs.getString(STORE_PREFS.USER_CAR_TYPE_ID!=null?STORE_PREFS.USER_CAR_TYPE_ID: "");
     USER_USER_CAR_VALET_ID= myPrefs.getString(STORE_PREFS.USER_CAR_VALET_ID!=null?STORE_PREFS.USER_CAR_VALET_ID: "");


     USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    print("==key=="+USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_CHECK_SERVICE_NAME, headers: {
      'x-api-key': USER_API_KEY,
    });

    SERVICE_TYPE_data = json.decode(response.body);
    setState(() {
      sERVICE_TYPE_LIST_DATA = SERVICE_TYPE_data["data"];
      service_name = sERVICE_TYPE_LIST_DATA[0]["servicename"].toString();
      if(service_name == "Domestic Cleaner"){
        Car_valter_name = "Building Details";
        Car_valeter_type = "Pets love & Room Details";
        getDomesticBookingDetail();
      }
      else{
        Car_valter_name = "Car Valeter";
        Car_valeter_type = "Valeter Type";
        getBookingDetail();
      }


    });

  }

  Future post_DOMESTIC_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_ADD_DOMESTIC_POST_URL,
          headers: {"x-api-key": USER_API_KEY
          },

          body: {
            'building_type': USER_DOMESTIC_BUILDING_TYPES_id,
            'building_size':  USER_DOMESTIC_BUILDING_SIZE_id,
            'room_size':  USER_DOMESTIC_BUILDING_NO_ROOMS_id,
            'pets':  USER_DOMESTIC_LOVE_PET_id,
            'service_type': USER_DOMESTIC_USER_SERVICE_TYPE,
            'address':  USER_DOMESTIC_USER_BOOKING_ADDRESS,
            'flat':  USER_DOMESTIC_USER_BOOKING_FLAT,
            'name':  USER_DOMESTIC_USER_BOOKING_ADDRESS_NAME,
            'phone': USER_DOMESTIC_USER_BOOKING_PHONE,
            'code':  USER_DOMESTIC_USER_BOOKING_INSTRUCTION_CODE,
            'keyfile':  USER_DOMESTIC_USER_BOOKING_KEYFILE_NAME,
            'type':  USER_DOMESTIC_USER_BOOKING_SAVED_ADDRESS_TYPE,
            'lat': USER_DOMESTIC_USER_BOOKING_LAT,
            'log':  USER_DOMESTIC_USER_BOOKING_LOG,
            'userDate':  USER_DOMESTIC_USER_BOOKING_DATE,
            'userTime':  USER_DOMESTIC_USER_BOOKING_TIME,
            'price':  booking_price_car,
            'hours':  USER_DOMESTIC_USER_BOOKING_HOUR,

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("POST_USER_ADD_DOMESTIC_POST_ status: ${response.statusCode}");
        print("POST_USER_ADD_DOMESTICListResponse body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {
            Fluttertoast.showToast(msg: jsonData["message"].toString());

            _navigateToNextScreen(context);


          }

          else {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }
  Future post_CAR_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);


    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_ADD_DOMESTIC_POST_URL,
          headers: {"x-api-key": USER_API_KEY
          },

          body: {
            'car_type': USER_USER_CAR_TYPE_ID,
            'service':  USER_USER_CAR_VALET_ID,

            'service_type': USER_DOMESTIC_USER_SERVICE_TYPE,
            'address':  USER_DOMESTIC_USER_BOOKING_ADDRESS,
            'flat':  USER_DOMESTIC_USER_BOOKING_FLAT,
            'name':  USER_DOMESTIC_USER_BOOKING_ADDRESS_NAME,
            'phone': USER_DOMESTIC_USER_BOOKING_PHONE,
            'code':  USER_DOMESTIC_USER_BOOKING_INSTRUCTION_CODE,
            'keyfile':  USER_DOMESTIC_USER_BOOKING_KEYFILE_NAME,
            'type':  USER_DOMESTIC_USER_BOOKING_SAVED_ADDRESS_TYPE,
            'lat': USER_DOMESTIC_USER_BOOKING_LAT,
            'log':  USER_DOMESTIC_USER_BOOKING_LOG,
            'userDate':  USER_DOMESTIC_USER_BOOKING_DATE,
            'userTime':  USER_DOMESTIC_USER_BOOKING_TIME,
            'price':  booking_price_car,


          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("POST_USER_ADD_DOMESTIC_POST_ status: ${response.statusCode}");
        print("POST_USER_ADD_DOMESTICListResponse body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {
            Fluttertoast.showToast(msg: jsonData["message"].toString());

            _navigateToNextScreen(context);


          }

          else {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }

  Future getDomesticBookingDetail() async {

    booking_price = booking_price_car;
    booking_date = USER_DOMESTIC_USER_BOOKING_DATE;
    booking_time = USER_DOMESTIC_USER_BOOKING_TIME;

    booking_type = "Building Type: "+USER_DOMESTIC_BUILDING_TYPES_id + " , Building Size: " +USER_DOMESTIC_BUILDING_SIZE_id;
    valter_type = "Pets love: " +USER_DOMESTIC_LOVE_PET_id + " , No. of Rooms: " + USER_DOMESTIC_BUILDING_NO_ROOMS_id;

  }

  Future getBookingDetail() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    USER_SERVICE_TYPe = myPrefs.getString(STORE_PREFS.USER_SERVICE_TYPE);
    booking_price = booking_price_car;
    booking_date = USER_DOMESTIC_USER_BOOKING_DATE ;
    booking_time = USER_DOMESTIC_USER_BOOKING_TIME;
    print("====USER_USER_CAR_TYPE_ID==="+USER_USER_CAR_TYPE_ID);
    if (USER_USER_CAR_TYPE_ID == "1"){
      booking_type = "Car";
    }
    if (USER_USER_CAR_TYPE_ID == "3"){
      booking_type = "4x4";
    }
    if (USER_USER_CAR_TYPE_ID == "4"){
      booking_type = "Van";
    }

    valter_type = "Valet" + " " +USER_USER_CAR_VALET_ID;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataServiceName();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Your Selected Item',
                      style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 22),
                      textAlign: TextAlign.center
                  ),
                ),),
              new Container(

                child: Card(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:15,left: 14,right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                                'Address for service',
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:8,left: 14,right: 14),

                         child:Text(
                                USER_DOMESTIC_USER_BOOKING_ADDRESS,
                                style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,),
                                textAlign: TextAlign.start
                           ),


                      ),
                      Container(
                        padding: EdgeInsets.only(top:29,left: 14,right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                                'Date',
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),
                            new Container(

                              child: Text(
                                  booking_date!=null?booking_date: "",
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.end
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:17,left: 14,right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                                'Time',
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),
                            new Container(

                              child: Text(
                                  booking_time!=null?booking_time: "",
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.end
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:17,left: 14,right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                                'Price',
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),
                            new Container(

                              child: Text(
                                  booking_price_car,
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.end
                              ),

                            )

                          ],

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:26),
                      height: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                     ),
                      Container(
                        padding: EdgeInsets.only(top:18,left: 14,right: 14,bottom: 26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                                'Total',
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),
                            new Container(

                                child: Text(
                                    booking_price_car,
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.end
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              new Container(
                margin: EdgeInsets.only(left: 7,right: 7,top: 26),
                child: Card(
                  color: Color.fromRGBO(248, 248, 248, 1),


                  child: Column(

                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(18, 14, 0, 0),
                        child:Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Car_valter_name!=null?Car_valter_name: "",
                            style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),

                          ),
                        ),),

                      Container(
                        padding: EdgeInsets.all(9.0),

                        child: Row(
                          children: <Widget>[

                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                                child:Row(

                                  children: <Widget>[
                                    Icon(Icons.check_box,color: Color.fromRGBO(125, 121, 204, 1),),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                        child:
                                        Text(  booking_type!=null?booking_type: "",
                                          style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                                    ),

                                  ],
                                )
                            )






                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(18, 16, 0, 0),
                        child:Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Car_valeter_type!=null?Car_valeter_type: "",
                            style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),

                          ),
                        ),),
                      Container(

                        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                        child: Row(

                          children: <Widget>[



                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                                child:Row(

//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[

                                    Icon(Icons.check_box,color: Color.fromRGBO(125, 121, 204, 1),),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                        child:
                                        Text( valter_type!=null?valter_type: "",
                                          style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                                    ),

                                  ],
                                )
                            )






                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left:18,top:15,bottom: 25),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [

                            Text(
                                booking_price_car,
                                style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                textAlign: TextAlign.start
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],),



        ],

      )),
      bottomNavigationBar: new Container(

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

                                  Text(booking_price_car,style: TextStyle(color: Colors.white,fontSize: 16)),
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
                                if(service_name == "Domestic Cleaner"){
                                  post_DOMESTIC_data();
                                }else{
                                  post_CAR_data();
                                }


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
      ),


    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Payment()),
    );
  }

}