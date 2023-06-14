import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/AddLocation/TrackOrder.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/reschdule.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


//import 'add_new_address.dart';

class PaymentSucess extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _PaymentSucess();
  }
}

class _PaymentSucess extends State<PaymentSucess> {

  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;
  String USER_API_KEY="",service_name="";
  Map SERVICE_TYPE_data;
  List sERVICE_TYPE_LIST_DATA;
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
// Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
// Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
// Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
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
            icon: Icon(Icons.arrow_back_ios, color: Color.fromRGBO(125, 121, 204, 1)),)
      ),
      body:  SingleChildScrollView(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(

            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                ],),




              new Container(

                child: Column(

                  children: [

                    Padding(
                        padding: EdgeInsets.only(top: 108),

                        child:Image.asset('assets/images/check.png',height: 111,width: 123,)),
                    Padding(
                      padding: EdgeInsets.only(top: 26),
                      child: Text(
                        "Booking Accepted",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Color.fromRGBO(76, 217, 100, 1)),

                      ),
                    ),
                    Container(

                      padding: EdgeInsets.only(top:24.0,left: 24,right: 24),

                      child: Center(
                        child: Text(
                          "Your Booking will be assigned 1 hour before the scheduled time",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Color.fromRGBO(145, 145, 145, 1)),

                        ),
                      ),
                    ),

                    Container(
margin: EdgeInsets.only(top: 60),

                        child: FlatButton(
                          height: 50,
                          minWidth: 170,
                          color: Color.fromRGBO(241, 123, 72 ,1),
                          onPressed: (){

                            _navigateToHomeScreen(context);

                          },

                          child: Text("Tack Order",style: TextStyle(fontSize:16,color: Colors.white),),)),

                  ],
                ),

              ),
            ],),



        ],

      ),),



    );
  }
 void _navigateToNextScreen(BuildContext context) {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => Reschdule()),
 );
 }
  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
    );
  }
  void _navigateToViewDetail(BuildContext context) {
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