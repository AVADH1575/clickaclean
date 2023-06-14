import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_fourth.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationThird extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalInformationThird();
  }
}
class _PersonalInformationThird extends State<PersonalInformationThird> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  DateTime Datenow;
  DateTime current_date;
  var myFormat = DateFormat('d-MM-yyyy');
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() async {
        selectedDate = picked;
        _date.value = TextEditingValue(text: myFormat.format(selectedDate));

        SharedPreferences myPrefs = await SharedPreferences.getInstance();
        myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Third_DOB,
            myFormat.format(selectedDate).toString());


      });
  }
  void GetCurrentDate(){
    Datenow = new DateTime.now();
     current_date = new DateTime(Datenow.day, Datenow.month, Datenow.year);
  }
  Future<void> checkStore()
  async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    print("==Email=="+myPrefs.getString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_Second_PHONE).toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStore();
    GetCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                                        percent: 0.6,

                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.help,color: Colors.white,)

                                  ],
                                ),

                              )),



                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 28, 23, 0),
                                child:
                                Text("Date of Birth*",
                                  style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                            ),
                          ),

              Padding(
                padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                child:
                          GestureDetector(
                onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _date,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            hintText: 'Date of Birth',

          ),
        ),
      ),
    ),),
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
                                                if(_date.text.toString() == ""){
                                                  Fluttertoast.showToast(
                                                      msg: "Please Choose DOB",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIos: 1
                                                  );
                                                }

                                                else{
                                                  _navigateToNextScreen(context);
                                                }
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
      MaterialPageRoute(builder: (context) => PersonalInformationFourth()),
    );
  }

}