import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'IdentityAllowCameraAccess.dart';

class VerifyCountryChoose extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyCountryChoose();
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
class _VerifyCountryChoose extends State<VerifyCountryChoose> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;


  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
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
      appBar: AppBar(title: Text("Select issuing country"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            SingleChildScrollView(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[
                Container(
                  margin:  EdgeInsets.fromLTRB(33, 29, 33, 0),
                  height: 40,
                decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
                color: Colors.white
            ),
               child: FlatButton(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                   children: <Widget>[

                     Text('${_selectedCompany.name}'),
                     DropdownButton(
                       items: _dropdownMenuItems,
                       onChanged: onChangeDropdownItem,
                     ),

                   ],
                 ),
               ),
                ),
                          ]),
                  ],))),
      bottomNavigationBar: new Container(
        child: Container(

          color: Color.fromRGBO(241, 123, 72, 1),
          height: 52,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  onPressed: (){
                    _navigateToNextScreen(context);
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
                                  _navigateToNextScreen(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Next",style: TextStyle(color: Colors.white,fontSize: 16)),
                                    Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                  ],)
                            ),),
                        ],),
                    ],
                  ),
                ),),
            ],),
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentityAllowCameraAccess()),
    );
  }

}