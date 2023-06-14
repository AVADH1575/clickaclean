import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_fifth.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class PersonalInformationFourth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalInformationFourth();
  }
}
class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'India'),
      Company(2, 'China'),
      Company(3, 'Pakistan'),
      Company(4, 'Nepal'),
      Company(5, 'UK'),
      Company(6, 'USA'),
      Company(7, 'CANADA'),
      Company(8, 'SHRI LANKA'),
      Company(9, 'UAE'),
      Company(10, 'SAUDI ARABIA'),
    ];
  }
}
class _PersonalInformationFourth extends State<PersonalInformationFourth> {
  TextEditingController nameController = TextEditingController();

  String value = "";
  String _mySelection,_mySelection1;
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
  List select_size_data = List();
  SharedPreferences myPrefs;
  void getStoreData() async {

     myPrefs = await SharedPreferences.getInstance();

    if(_selectedCompany.name == null ||  _selectedCompany.name == "")
    {
      Fluttertoast.showToast(
          msg: "Please choose country",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
    }
    else {
      myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Four_HOME_COUNTRY,
          _selectedCompany.name.toString());
print("===check_company_selected==="+ _selectedCompany.name.toString());
      _navigateToNextScreen(context);
    }
  }
  Future<String> getcountry_data() async {
    myPrefs = await SharedPreferences.getInstance();
    var res = await http
        .get(Uri.encodeFull(APPURLS_PROVIDER.GET_PROVIDER_COUNTRY_LIST_URL), headers: { 'x-api-key': "boguskey"});
    var resBody = json.decode(res.body);


    setState(() {
      //select_size_data = resBody;
      select_size_data = resBody["data"];

    });

    print(resBody);

    return "Success";
  }
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    getcountry_data();
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding:  EdgeInsets.fromLTRB(10, 0, 15, 0),
                            color: Color.fromRGBO(241, 123, 72, 1),
                            height: 73,
                            child:Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: <Widget>[

                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.arrow_back_ios,color: Colors.white)
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child:  LinearPercentIndicator(
                                      width: 210,
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 2000,
                                      percent: 0.8,

                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.white,
                                    ),
                                  ),
                                  Icon(Icons.help,color: Colors.white,)
                                  //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),

//                           Column(
//                               children: <Widget>[
//                            FlatButton(
//                              onPressed: () {},
//                              child:Icon(Icons.play_circle_filled,color: Color.fromRGBO(241, 123, 72, 1),)
//                            )],)
                                ],
                              ),

                            )),



                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding:  EdgeInsets.fromLTRB(23, 28, 23, 0),
                              child:
                              Text("Home address country*",
                                style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                          ),
                        ),
              Container(
                margin:  EdgeInsets.fromLTRB(23, 12, 23, 0),
                height: 40,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
                    color: Colors.white
                ),
                child:  new DropdownButton(
                  hint: Text('        Choose your home country      '),

                  items: select_size_data.map((item) {
                    return new DropdownMenuItem(

                      child: new Text("  "+item['name']+""),
                      value: item['name'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(()  {
                      _mySelection = newVal;
                      print("==Selected VALUE1==="+ _mySelection);

                      myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Four_HOME_COUNTRY,_mySelection);
                    });
                  },
                  value: _mySelection,
                ),

              ),
                        ],),

                    Align(
                      alignment: Alignment.center,

                      child:Container(

                        color: Color.fromRGBO(241, 123, 72, 1),
                        height: 49,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: FractionalOffset.bottomRight,
                              child: FlatButton(
                                onPressed: (){
                                  getStoreData();
                                },
                                child: Row(

                                  children: <Widget>[
                                    Row(

                                      children: <Widget>[
                                        FlatButton(
                                            onPressed: () {},
                                            child: Column(
                                              children: <Widget>[


                                              ],)
                                        ),
                                      ],),


//Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),


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
                                                getStoreData();
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("Next",style: TextStyle(color: Colors.white,fontSize: 16,)),
                                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                                ],)
                                          ),),
                                      ],),


                                  ],
                                ),
                              ),),

                          ],),
                      ),)


                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonalInformationFifth()),
    );
  }

}