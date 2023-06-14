import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalInformationFirst();
  }
}
class _PersonalInformationFirst extends State<PersonalInformationFirst> {
  TextEditingController FirstNameField = TextEditingController();
  TextEditingController LastNameField = TextEditingController();
  TextEditingController MiddleNameField = TextEditingController();
  SharedPreferences myPrefs;

  String value = "";

  void PostStoreData() async {

 SharedPreferences myPrefs = await SharedPreferences.getInstance();

 if(LastNameField.text.toString() == null ||  LastNameField.text.toString() == "" || FirstNameField.text.toString() == null || FirstNameField.text.toString() == "")

  {
    Fluttertoast.showToast(
        msg: "Please enter required fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }
 else {
   myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_LAST_NAME,
       LastNameField.text.toString());
   myPrefs.setString(
       STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_MIDDLE_NAME,
       MiddleNameField.text.toString());
   myPrefs.setString(STORE_PREFS_PROVIDER.PERSONAL_INFORMATION_First_FIRST_NAME,
       FirstNameField.text.toString());

   _navigateToNextScreen(context);
 }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(

          child:
        SingleChildScrollView(

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
                  percent: 0.2,

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
                 child:Padding(
                  padding:  EdgeInsets.fromLTRB(23, 14, 23, 0),
                  child:
                  Text("Please enter your details as they appear on your identification documents.",
                  style: TextStyle(color: Color.fromRGBO(255, 51, 51, 1) ,fontSize: 14),)
                 ),
                 ),

          Align(
              alignment: Alignment.topLeft,
                     child: Padding(
                          padding:  EdgeInsets.fromLTRB(23, 14, 23, 0),
                          child:
                          Text("First name*",
                            style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                      ),
          ),
               Padding(
                   padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                child: TextField(
                  controller: FirstNameField,
                  style: TextStyle(
                    fontSize: 14.0,

                  ),
                  cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                  decoration: InputDecoration(

                    hintText: 'First name',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                  ),),

                ))
                ,
          Align(
              alignment: Alignment.topLeft,
                child:Padding(
                    padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                    child:Text('Middle/Other name(s)',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14))
                ),),
                Padding(
                    padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                    child: TextField(
                      controller: MiddleNameField,
                      style: TextStyle(
                        fontSize: 14.0,

                      ),
                      cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                      decoration: InputDecoration(
                        hintText: 'Middle/Other name(s)',

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                        ),),

                    ))
                ,

          Align(
            alignment: Alignment.topLeft,
                      child:Padding(
                    padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                    child:Text('Last name*',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                ),),
                Padding(
                    padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                    child: TextField(
                      controller: LastNameField,
                        style: TextStyle(
                            fontSize: 14.0,

                        ),

                      cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                      decoration: InputDecoration(
                        hintText: 'Surname',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                        ),),

                    ))
                ,
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
                    PostStoreData();
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
                                onPressed: () async {

                                  setState(() {

                                  });
                               PostStoreData();

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
      MaterialPageRoute(builder: (context) => PersonalInformationSecond()),
    );
  }

}