import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Authentication/ProviderLogin.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:click_a_clean/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProviderChooseCountry extends StatefulWidget {
  @override
  _ProviderChooseCountry createState() => _ProviderChooseCountry();
}

class _ProviderChooseCountry extends State<ProviderChooseCountry> {

  Map data;
  List userData;
  bool a = true;
  bool _visible = false;
  SharedPreferences myPrefs;

  Future getData() async {
    myPrefs = await SharedPreferences.getInstance();

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_COUNTRY_LIST_URL, headers: {
      'x-api-key': 'boguskey',
    });

    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
      print("===country data==="+userData.toString());
    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int _selectedIndex;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
      print("===phone_code==="+userData[index]["phone_code"].toString());
      myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_COUNTRY_CODE,userData[index]["phone_code"].toString());

    });
  }
  bool viewVisible = false ;

  void showWidget(int i){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                color: Color.fromRGBO(241, 123, 72, 1),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/images/white-logo.svg',

                          // fit: BoxFit.contain,
                          height: 50,


                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,

                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Welcome to Click A Clean\n',
                              style: TextStyle(color: Colors.white,fontSize: 20.0 ), /*defining default style is optional */
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Choose a Country to get started', style: TextStyle(color: Colors.white,fontSize: 18.0)),

                              ],
                            ),
                          ),

                        )),
                  ],

                ),
              ),
              new ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(

                      onTap: ()  {
                        setState(() {
                          _onSelected(index);
                        });
                        //showWidget(userData[index]['id']);


                        _navigateToNextScreen(context);
                        // _navigateToNextScreen(context,userData[index]['id'].toString());
                        print("${userData[index]['id'].toString()}");
                      },
                      child:Card(
                        color: _selectedIndex != null && _selectedIndex == index
                            ? Color.fromRGBO(220,220,220,100)
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                  children:<Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(userData[index]["flag"]),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Container(

                                          child: Text("${userData[index]["name"]}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                        ))]),
                              Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: viewVisible,
                                  child: Container(
                                      height: 16,
                                      width: 16,
                                      color: Colors.green,
                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Center(child: Text('Show ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 10)))
                                  )
                              ),




                            ],
                          ),
                        ),
                      ));

                },
              ),])
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderLoginScreen()),
    );
  }

}