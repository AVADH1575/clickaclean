import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/Payment.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/CustomPopupMenu.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Add_new_address_manage_users.dart';
import 'add_new_address.dart';

class ManageAddress extends StatefulWidget {
  @override
  _Address createState() => _Address();
}


class _Address extends State<ManageAddress> {
  int delete_index;

  int _radioValue1 = -1;
  int correctScore = 0;
  List sERVICE_TYPE_LIST_DATA;
  String service_name,USER_API_KEY;
  SharedPreferences myPrefs;


  int _selectedIndex;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;

    });
  }

  Map data;
  List userData;


  Future post_Address_Delete_data(int index, String id) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_DELETE_ADDRESS_URL,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'id': id,

          }

      );

      if (response.statusCode == 200) {
        //enter your code

        print("Delete_ListResponse status: ${response.statusCode}");
        print("Delete_ListResponse body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {
          if (jsonData["status"] == true) {
            Fluttertoast.showToast(
                msg: jsonData["message"].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );
            getData();
          }

          else {
            print("Address_ListResponse else: ${response.statusCode}");
          }
        });
      }
    } on Exception catch (err) {
      print("Error : $err");
    }
    setState(() {
      delete_index = index ;
    });
  }



  Future getData() async {
    myPrefs = await SharedPreferences.getInstance();
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_ADDRESS_URL, headers: {
      'x-api-key': USER_API_KEY,
    });


    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
      print("===get address data==="+userData.toString());
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataServiceType();
    getData();


  }
  @override
  Widget build(BuildContext context) {
    getDataServiceType();
    getData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text("Manage Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                  child: Center(
                    child: Text(
                        'Select Address?',
                        style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 18),
                        textAlign: TextAlign.center
                    ),
                  ),),

                new Container(
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.black,height: 1,
                      ),

                      new ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: userData == null ? 0 : userData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(

                            onTap: () {
                              setState(() {
                                _onSelected(index);

                              });
                              print("${userData[index]['id'].toString()}");
                            },
                            child:
                            Container(
                              padding: EdgeInsets.all(0),
                              color: Colors.transparent,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child:Row(

                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child:Icon(Icons.fiber_manual_record,size: 12,),),

                                                Expanded(
                                                  child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        Container(
                                                          padding: EdgeInsets.only(left: 20,top: 10),
                                                          child: Text(
                                                              "${userData[index]['type'].toString()}",
                                                              style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 13),
                                                              textAlign: TextAlign.start
                                                          ),),
                                                        Container(
                                                          padding: EdgeInsets.only(left: 20),

                                                          child: Text(
                                                              "${userData[index]['address'].toString()}",
                                                              style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 13),
                                                              textAlign: TextAlign.start
                                                          ),),]),),]),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: IconButton(icon:Icon(Icons.delete_forever),color: Colors.black,onPressed: (){

                                              post_Address_Delete_data(index,userData[index]['id'].toString());
                                            },)),

                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(top: 13),
                                        child: Divider(color: Colors.black,height: 1,)),

                                  ]),
                            ),);

                        },
                      ),


                    ],
                  ),
                ),


                new Container(
                  child: Column(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left:20.0),
                        child:FlatButton(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                  'Add a new address',
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.start
                              ),
                              new Container(
                              ),
                            ],
                          ),onPressed: (){
                          _navigateToNextScreen(context);
                        },),
                      ),
                      Divider(
                          color: Colors.black
                      ),
                    ],
                  ),

                ),
              ],),



          ],

        ),),


    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(
        context, rootNavigator: true)
        .push(MaterialPageRoute(
        builder: (context) =>
            AddNewAddressManage(),
        maintainState: true));
  }

  void _navigateToPaymentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Time()),
    );
  }

}