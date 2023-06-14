import 'dart:io';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/booking_time.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarVelter extends StatefulWidget {
  @override
  _CarVelter createState() => _CarVelter();
}

class _CarVelter extends State<CarVelter> {
  String _myImage = "assets/images/logo_img.png";
  String USER_API_KEY,USER_CAR_TYPE_iD,USER_CAR_VALET_iD,car_type;
  String booking_price= "";
  Map CAR_TYPE_data;
  Map VELTER_BOOKING_PRICE_DATA;

  Map CAR_VELTERTYPE_data;
  String service_name;
  Map SERVICE_TYPE_data;


  List sERVICE_TYPE_LIST_DATA;
  List VELTER_BOOKING_PRICE_LIST_DATA;

  List CAR_TYPE_LIST_DATA;
  List CAR_VELTERTYPE_LIST_DATA ;
  bool a = true;
  SharedPreferences myPrefs;

  bool _visible = false;
  var isSelected = false;
  var mycolor=Colors.white;

  Future<String> getDATASTORE() async {
    myPrefs = await SharedPreferences.getInstance();
  }

  Future<dynamic> getData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_CAR_TYPE_URL, headers: {
      'x-api-key': USER_API_KEY,
    });


    CAR_TYPE_data = json.decode(response.body);
    setState(() {
      CAR_TYPE_LIST_DATA = CAR_TYPE_data["data"];
      print("===CAR_TYPE_LIST_DATA data==="+CAR_TYPE_LIST_DATA.toString());
    });

  }
  Future<dynamic> getCarVelterType() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_CAR_VELTER_SERVICE_URL, headers: {
      'x-api-key': USER_API_KEY,
    });


     CAR_VELTERTYPE_data = json.decode(response.body);
    setState(() {
      CAR_VELTERTYPE_LIST_DATA = CAR_VELTERTYPE_data["data"];
      print("===CAR_TYPE_LIST_DATA valeter data==="+CAR_VELTERTYPE_LIST_DATA.toString());
    });

  }

  Future getDataServiceType() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_CHECK_SERVICE_NAME, headers: {
      'x-api-key': USER_API_KEY,
    });


    var resBody = json.decode(response.body);
    setState(() {
      sERVICE_TYPE_LIST_DATA = resBody["data"];

      print("===service_type_data==="+sERVICE_TYPE_LIST_DATA.toString());
       service_name = sERVICE_TYPE_LIST_DATA[0]["servicename"].toString();

    });

  }
  Future post_carvelter_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    USER_CAR_TYPE_iD = myPrefs.getString(STORE_PREFS.USER_CAR_TYPE_ID);
    USER_CAR_VALET_iD = myPrefs.getString(STORE_PREFS.USER_CAR_VALET_ID);
    _navigateToNextScreen(context);
//    print("=====inputs==check==="+USER_CAR_TYPE_iD+"==="+USER_CAR_VALET_iD+"-====="+booking_price);
//    var client = new http.Client();
//    try {
//      var response = await client.post(
//          APPURLS_USER.POST_USER_ADD_CAR_POST_URL,
//          headers: {"x-api-key": USER_API_KEY
//          },
//
//          body: {
//            'car_type': USER_CAR_TYPE_iD,
//            'service':  USER_CAR_VALET_iD,
//            'price':  booking_price,
//          }
//
//      );
//
//      if (response.statusCode == 200 ) {
//        //enter your code
//
//        print("Booking_Detail_ListResponse status: ${response.statusCode}");
//        print("Booking_Detail_ListResponse body: ${response.body}");
//
//        final jsonData = json.decode(response.body);
//
//        setState(() {
//
//          if (jsonData["status"] == true) {
//
//            _navigateToNextScreen(context);
//            print("Booking_Detail_List : ${jsonData["data"][0]["service"]}");
//
//          }
//
//          else {
//
//          }
//        });
//
//      }
//    } on Exception catch (err) {
//      print("Error : $err");
//    }
  }
  Future post_CARVELTER_BOOKING(String car_type, String valet_type) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
print("===inputs+++"+car_type + "-----"+valet_type);
    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_CAR_VELTER_BOOKING_API,
          headers: {"x-api-key": USER_API_KEY
          },

          body: {
            'car': car_type,
            'valet':  valet_type,
          }
      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price_ListResponse status: ${response.statusCode}");
        print("pricel_ListResponse body: ${response.body}");

        var jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            VELTER_BOOKING_PRICE_LIST_DATA = jsonData["data"];
            print("price : ${jsonData["data"][0]["price"]}");

            booking_price = jsonData["data"][0]["price"].toString();
            myPrefs.setString(STORE_PREFS.USER_CAR_VALET_PRICE,booking_price);


          }

          else {

          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }

  int _selectedIndex,_selected_Index_second;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }
  _onSelected_second(int index) {

    setState(() {
      _selected_Index_second = index;
      post_CARVELTER_BOOKING(car_type, "Valet "+CAR_VELTERTYPE_LIST_DATA[index]['valeterid'].toString());

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getCarVelterType();
    getDataServiceType();
    getDATASTORE();


  }

  bool viewVisible = false ;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }

  int _currentIndex ;
  bool _isEnabled = true;

  _onChanged() {
    setState(() {
      _isEnabled = !_isEnabled;
    });
  }


  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);

      return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(125, 121, 204, 1),
          title: Text(service_name!=null?service_name: ""),
          centerTitle: true,
    leading: IconButton(
    icon: Icon(Icons.arrow_back_ios, color: Colors.white),    onPressed: () => Navigator.of(context).pop(),)


        ),

        body: SafeArea(

        child:SingleChildScrollView(

          child:Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
            children: <Widget>[

             Container(

              child: Flex(
//                shrinkWrap:true,
//                scrollDirection: Axis.vertical,
              direction: Axis.vertical,
                children: <Widget>[


                  SizedBox(height: 20.0,),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: new EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                      Text("CAR TYPE",textAlign: TextAlign.left)

                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    height: 120,

                   // GET_USER_CAR_TYPE_URL

                    ////////
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                      shrinkWrap: true,
                      itemCount: CAR_TYPE_LIST_DATA == null ? 0 : CAR_TYPE_LIST_DATA.length,
                          itemBuilder: (BuildContext context, int index) {

                       return GestureDetector(

                          onTap: () {
                            setState(()  {
                              _onSelected(index);

                              myPrefs.setString(STORE_PREFS.USER_CAR_TYPE_ID,CAR_TYPE_LIST_DATA[index]['id'].toString());
                             car_type = CAR_TYPE_LIST_DATA[index]["name"];

                            });


                       // _navigateToNextScreen(context);
                         // _navigateToNextScreen(context,userData[index]['id'].toString());
                          print("${CAR_TYPE_LIST_DATA[index]['id'].toString()}");
                          },
                        child:
                            Card(
                                color: _selectedIndex != null && _selectedIndex == index
                                    ? Color.fromRGBO(238, 238, 238, 1)
                                    : Colors.white,
                        child:Container(
                            margin: EdgeInsets.only(left: 1.0,right: 1),
                            width: 132,

                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(CAR_TYPE_LIST_DATA[index]["car_img"],height: 25,width: 84,),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3),
                                  child:Text("${CAR_TYPE_LIST_DATA[index]["name"]}")),

                                ]
                            )

                        ))

                       );

                    }

                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0),
                    child:Container(
                      height: 195,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/car-bg.png"), fit: BoxFit.cover)),
                      child: Column(

                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 65.0, left: 20.0,right: 70),

                                child:Text(
                                  'TYPES OF \n VALETER',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),),



                            ],),],),),),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.only(left: 5.0,right: 5.0),
                    height: 165,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: CAR_VELTERTYPE_LIST_DATA == null ? 0 : CAR_VELTERTYPE_LIST_DATA.length,
                        itemBuilder: (BuildContext context, int index) {

                          return GestureDetector(

                              onTap: ()  {
                                setState(()  {
                                  showWidget();
                                  _onSelected_second(index);
                                    myPrefs.setString(STORE_PREFS.USER_CAR_VALET_ID,CAR_VELTERTYPE_LIST_DATA[index]['valeterid'].toString());

                                });

                                print("===valter_id===${CAR_VELTERTYPE_LIST_DATA[index]['valeterid'].toString()}");
                              },
                              child: Card(
                                  color: _selected_Index_second != null && _selected_Index_second == index
                                     ? Color.fromRGBO(228, 232, 254, 1) : Colors.white,
//                                  shape: new RoundedRectangleBorder(
//                                      side: new BorderSide(color:_selected_Index_second != null && _selected_Index_second == index
//                                      ? Color.fromRGBO(228, 232, 254, 1)
//                                          : Colors.white, width: 1.0),
//                                      borderRadius: BorderRadius.circular(4.0)),
                              child:Container(
                                  margin: EdgeInsets.only(left: 1.0,right: 1),
                                  padding: EdgeInsets.only(left: 5.0,right: 5),
                                  width: 140,


                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Valet ${CAR_VELTERTYPE_LIST_DATA[index]["valeterid"]}"),
                                        SizedBox(height: 10.0,),
                                        Text("${CAR_VELTERTYPE_LIST_DATA[index]["valetername"]}",textAlign: TextAlign.center,),
                                        SizedBox(height: 10.0,),

                                      ]
                                  )
                              ))

                          );

                        }


                    )),


             SizedBox(height:50)


                ],
              ),
            ),


]

        ))),
        bottomNavigationBar: Visibility(
          visible: viewVisible,
          child: new Container(

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
          ),
        ),
      ),
    );

  }


  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingTime()),
    );
  }
}