
import 'package:click_a_clean/ApiHit/SharedPrefs/SharedPrefers.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/BookingTimeDomestic.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/booking_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DomesticCleaner extends StatefulWidget {
  DomesticCleaner() : super();
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DomesticCleaner();
  }
}

class _DomesticCleaner extends State<DomesticCleaner> {

  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;
  List sERVICE_TYPE_LIST_DATA;

  String service_name;
  SharedPreferences myPrefs;
  String _mySelection,_mySelection1;
  String USER_DOMESTIC_BUILDING_TYPES_id,USER_DOMESTIC_BUILDING_SIZE_id,USER_DOMESTIC_BUILDING_NO_ROOMS_id,USER_DOMESTIC_LOVE_PET_id;


  Map building_data;

  List building_type_data;
  String USER_API_KEY;

  List select_size_data = List(); //edited line
  List room_no_data = List(); //edited line

  bool a = true;
  Future getBuildingData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_DOMESTIC_HOUSES_URL, headers: {
      'x-api-key': USER_API_KEY,
    });


    building_data = json.decode(response.body);
    setState(() {
      building_type_data = building_data["data"];

    });

  }
  Future<String> getRoomListData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    var res = await http
        .get(Uri.encodeFull(APPURLS_USER.GET_USER_DOMESTIC_ROOMS_LIST_URL), headers: { 'x-api-key': USER_API_KEY});
    var resBody = json.decode(res.body);


    setState(() {
      //select_size_data = resBody;
      room_no_data = resBody["data"];

    });

    print(resBody);

    return "Success";
  }

  Future<String> getSizeData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    var res = await http
        .get(Uri.encodeFull(APPURLS_USER.GET_USER_DOMESTIC_SIZE_URL), headers: { 'x-api-key': USER_API_KEY});
    var resBody = json.decode(res.body);


    setState(() {
      //select_size_data = resBody;
      select_size_data = resBody["data"];

    });

    print(resBody);

    return "Success";
  }
  Future<String> getDATASTORE() async {
     myPrefs = await SharedPreferences.getInstance();
  }

  Future post_DOMESTIC_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    USER_DOMESTIC_BUILDING_TYPES_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_TYPES_ID);
    USER_DOMESTIC_BUILDING_SIZE_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_SIZE);
    USER_DOMESTIC_BUILDING_NO_ROOMS_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_BUILDING_NO_ROOMS);
    USER_DOMESTIC_LOVE_PET_id = myPrefs.getString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID);
    print("=====inputs====="+USER_API_KEY + "===build_id=="+ USER_DOMESTIC_BUILDING_TYPES_id +"===size=="+USER_DOMESTIC_BUILDING_SIZE_id + "===="+ USER_DOMESTIC_BUILDING_NO_ROOMS_id + "====="+USER_DOMESTIC_LOVE_PET_id);
    _navigateToNextScreen(context);
//    var client = new http.Client();
//    try {
//      var response = await client.post(
//          APPURLS_USER.POST_USER_ADD_DOMESTIC_POST_URL,
//          headers: {"x-api-key": USER_API_KEY
//          },
//
//          body: {
//            'building_type': USER_DOMESTIC_BUILDING_TYPES_id,
//            'building_size':  USER_DOMESTIC_BUILDING_SIZE_id,
//            'room_size':  USER_DOMESTIC_BUILDING_NO_ROOMS_id,
//            'pets':  USER_DOMESTIC_LOVE_PET_id,
//          }
//
//      );
//
//      if (response.statusCode == 200 ) {
//        //enter your code
//
//        print("POST_USER_ADD_DOMESTIC_POST_ status: ${response.statusCode}");
//        print("POST_USER_ADD_DOMESTICListResponse body: ${response.body}");
//
//        final jsonData = json.decode(response.body);
//
//        setState(() {
//
//          if (jsonData["status"] == true) {
//
//            _navigateToNextScreen(context);
//
//
//          }
//
//          else {
//            Fluttertoast.showToast(
//                msg: "Something went wrong",
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.CENTER,
//                timeInSecForIos: 1
//            );
//          }
//        });
//
//      }
//    } on Exception catch (err) {
//      print("Error : $err");
//    }
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
  @override
  void initState() {
    super.initState();

    this.getBuildingData();
    this.getRoomListData();
    this.getSizeData();
    getDataServiceType();

    getDATASTORE();

  }
  int _selectedIndex,_selected_Index_second;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
    });
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




  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
       //   Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
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

  @override
  Widget build(BuildContext context) {
    String radioItem = '';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromRGBO(125, 121, 204, 1),title: Text(service_name!=null?service_name: ""),centerTitle: true, leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),    onPressed: () => Navigator.of(context).pop(),)),
        body: SafeArea(
        child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
               Column(
          children: <Widget>[


                  SizedBox(height: 20.0,),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: new EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                      Text("BUILDING TYPES",textAlign: TextAlign.left)

                  ),


            new GridView.builder(
              shrinkWrap: true,
              itemCount: building_type_data == null ? 0 : building_type_data.length,

              padding: const EdgeInsets.only(left:20.0,right: 20,top: 10),

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(

                    onTap: () {
                      setState(() {
                        _onSelected(index);

                        myPrefs.setString(STORE_PREFS.USER_DOMESTIC_BUILDING_TYPES_ID,building_type_data[index]['name'].toString());


                      });

                         print("${building_type_data[index]['id'].toString()}");
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        color:  _selectedIndex != null && _selectedIndex == index
                            ? Color.fromRGBO(250, 250, 250, 1)
                            : Colors.transparent,
                        border: Border.all(
                          color:  _selectedIndex != null && _selectedIndex == index
                              ? Color.fromRGBO(125, 121, 204, 1)
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(2.0),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(0.0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                children:<Widget>[

                                  Image.network(building_type_data[index]["building_img"],height: 85,width: 90,),
                                  Container(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Container(

                                        child: Text("${building_type_data[index]["name"]}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                      ))]),

                          ],
                        ),
                      ),
                    ));

              },
            ),




          Padding(
            padding: EdgeInsets.only(top:20.0, left: 16.0,right: 10),
            child:IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Expanded(
                  child: Column(children: [

                    Container(height: 42.0, color: Colors.transparent,

                      child: Container(

                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
                          color: Color.fromRGBO(229, 233, 255, 1),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[

                        new DropdownButton(
                         hint: Text('Select Size'),

                        items: select_size_data.map((item) {
                      return new DropdownMenuItem(
                      child: new Text(item['size']+"          "),
                      value: item['size'].toString(),
                      );
                      }).toList(),
                    onChanged: (newVal) {
                      setState(()  {
                        _mySelection = newVal;
                        print("==Selected VALUE1==="+ _mySelection);

                        myPrefs.setString(STORE_PREFS.USER_DOMESTIC_BUILDING_SIZE,_mySelection);
                      });
                    },
                    value: _mySelection,
                  ),
              ])

                      ),
                    ),
                  ]),
                ),

                SizedBox(width: 5,),
                Expanded(child: Container(height: 42.0,color: Colors.transparent,  child: Container(

                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
                    color: Color.fromRGBO(229, 233, 255, 1),
                  ),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      new DropdownButton(
                        hint: Text('No. of Rooms'),
                        items: room_no_data.map((item) {
                          return new DropdownMenuItem(

                            child: new Text(item['rooms']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _mySelection1 = newVal;
                            print("==Selected VALUE2==="+ _mySelection1);

                            myPrefs.setString(STORE_PREFS.USER_DOMESTIC_BUILDING_NO_ROOMS,_mySelection1);


                          });
                        },
                        value: _mySelection1,
                      ),
                    ],
                  ),
                ),


                )),
              ]),
            ),),


                  Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 8,bottom: 10),
                    child:Container(
                      height: 195,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage('assets/images/dog-bg.png'),
                            fit: BoxFit.fill,
                          )
                      ),
                      child: Column(

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top:65.0, left: 20.0,right: 70),
                                child:Text(
                                  'Do you \n Love Pets?',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),),

                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(0.0),
                                    child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[


                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Radio(
                                                value: 0,
                                                groupValue: _currentIndex,

                                                onChanged: _isEnabled
                                                    ? (val) {
                                                  setState(()  {
                                                    _currentIndex = val;
                                                    showWidget();

                                                    myPrefs.setString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID,"Yes");
                                                    print("===check love pets_id1=="+ myPrefs.getString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID));

                                                  });
                                                }
                                                    : null,
                                              ),
                                              new Text(
                                                'Yes',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 1,
                                                groupValue: _currentIndex,

                                                onChanged: _isEnabled
                                                    ? (val) {
                                                  setState(() {
                                                    _currentIndex = val;
                                                    showWidget();

                                                    myPrefs.setString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID,"No");
                                                    print("===check love pets_id2=="+ myPrefs.getString(STORE_PREFS.USER_DOMESTIC_LOVE_PET_ID));
                                                  });
                                                }
                                                    : null,
                                              ),
                                              new Text(
                                                'No',
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),

                                            ],
                                          ),



                                        ]),),


                                ],),




                            ////
                            ],),],),),),


],),


                ],
              ),),



          ),
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

                                    Text("",style: TextStyle(color: Colors.white,fontSize: 16)),
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
                                onPressed: ()  {
                                  setState(() {
                                    post_DOMESTIC_data();
                                  });

                                  //_navigateToNextScreen(context);
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
      MaterialPageRoute(builder: (context) => BookingTimeDomestic()),
    );
  }

}
