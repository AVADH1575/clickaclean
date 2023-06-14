import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Profile/provider_profile_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EditIdentityScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditIdentityScreen();
  }
}
class _EditIdentityScreen extends State<EditIdentityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  List Document_list = List();
  String doc_type,idFront,idBack;
  SharedPreferences myPrefs;
  String document_type;


  Future<String> getIdentityData() async {
     myPrefs = await SharedPreferences.getInstance();

    var res = await http
        .get(Uri.encodeFull(APPURLS_PROVIDER.GET_PROVIDER_DOCUMENT_LIST), headers: { 'x-api-key':  myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)});
    var resBody = json.decode(res.body);

    setState(() {
      //select_size_data = resBody;
      Document_list = resBody["data"];
      doc_type = Document_list[0]["type"].toString();
      idFront =  Document_list[0]["idFront"].toString();
      idBack =  Document_list[0]["idBack"].toString();

    });

    print(resBody);
    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdentityData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Identity"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[
                          Container(
                            margin:  EdgeInsets.fromLTRB(33, 29, 33, 0),
                            height: 46,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
                                color: Colors.white
                            ),
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: <Widget>[
                                  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: <Widget>[
                                  Padding(
                              padding: EdgeInsets.only(top: 4, left: 2, bottom: 2),
                                 child: Text("Type of ID",style: TextStyle(color: Color.fromRGBO(197, 197, 197, 1),fontSize: 12))),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2, left: 2, bottom: 4),
                                 child: Text(doc_type!= null ? doc_type: "",style: TextStyle(color: Colors.black,fontSize: 14))),
                                ],),


//                                  Container(height: 42.0, color: Colors.transparent,
//
//                                    child: Container(
//
//                                        decoration: new BoxDecoration(
//                                          borderRadius: BorderRadius.circular(8.0),
//                                          border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
//                                          color: Color.fromRGBO(229, 233, 255, 1),
//                                        ),
//
//                                        child: Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                            children: <Widget>[
//
//                                              new DropdownButton(
//                                                hint: Text('Select Size'),
//
//                                                items: select_size_data.map((item) {
//                                                  return new DropdownMenuItem(
//                                                    child: new Text(item['type']+"          "),
//                                                    value: item['type'].toString(),
//                                                  );
//                                                }).toList(),
//                                                onChanged: (newVal) {
//                                                  setState(()  {
//                                                    _mySelection = newVal;
//                                                    print("==Selected VALUE1==="+ _mySelection);
//
//                                                  });
//                                                },
//                                                value: _mySelection,
//                                              ),
//                                            ])
//
//                                    ),
//                                  ),




                                ],
                              ),
                            ),

                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(top: 30,right: 10),
                            height: 139,
                            width: 139,
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/background_image.png',
                                  image: idFront!= null ? idFront: "",fit: BoxFit.cover,
                              )

                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30,right: 10),
                              height: 139,
                              width: 139,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/background_image.png',
                                image: idBack!= null ? idBack: "",fit: BoxFit.cover,
                              )

                          )])

                        ]),



//                    Align(
//                      alignment: Alignment.center,
//
//                      child:Container(
//
//                        color: Color.fromRGBO(241, 123, 72, 1),
//                        height: 49,
//
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Align(
//                              alignment: FractionalOffset.bottomRight,
//                              child: FlatButton(
//                                onPressed: (){
//                                  //_navigateToNextScreen(context);
//                                },
//                                child: Row(
//
//                                  children: <Widget>[
//                                    Row(
//
//                                      children: <Widget>[
//                                        FlatButton(
//                                            onPressed: () {},
//                                            child: Column(
//                                              children: <Widget>[
//
//
//                                              ],)
//                                        ),
//                                      ],),
//
//                                  ],
//                                ),
//                              ),),
//                            Align(
//                              alignment: FractionalOffset.bottomRight,
//                              child: FlatButton(
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.center,
//                                      crossAxisAlignment: CrossAxisAlignment.center,
//                                      children: <Widget>[
//                                        Align(
//                                          alignment: FractionalOffset.center,
//                                          child:FlatButton(
//                                              onPressed: () {
//                                               // _navigateToNextScreen(context);
//                                              },
//                                              child: Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                crossAxisAlignment: CrossAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 16)),
//                                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
//                                                ],)
//                                          ),),
//                                      ],),
//                                  ],
//                                ),
//                              ),),
//                          ],),
//                      ),)
                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProvideProfileScreen()),
    );
  }

}