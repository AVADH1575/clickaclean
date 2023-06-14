import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Authentication/ProviderChooseCountry.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Home/ChooseProfessionProvider.dart';
import 'package:click_a_clean/UserEnd/ChooseCountry/CountryListUserApiHitGet.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chooseuser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}
class _State extends State<Chooseuser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));}

  SharedPreferences myPrefs;
  String USER_API_KEY,PROVIDER_API_KEY;

  void CheckLoginAuthentication() async{
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    if(USER_API_KEY == null){
      _navigateToNextScreen(context);
    }
    else{
      _navigateToHomeScreen(context);
    }

  }
  void CheckProviderLoginAuthentication() async{
    myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);
    if(PROVIDER_API_KEY == null){
      _navigateToNextScreen1(context);
    }
    else{
      _navigateToProviderHomeScreen(context);
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
        key: scaffoldKey,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          color: Color.fromRGBO(81, 92, 111, 1), fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )
                ),

                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 9, 20, 0),
                    padding: EdgeInsets.all(10),
                    child: Text(

                      'A Trusted Cleaning Service You’ll Love!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18,color: Color.fromRGBO(125, 121, 204, 1), fontFamily: 'Roboto',fontWeight: FontWeight.w100),
                    )),

                Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child:  Image(image: AssetImage("assets/images/welcome@2x.png"))
                ),

                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(125, 121, 204, 1),

                      child: Text('Are you a User?',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),),
                      onPressed: () {
                        print(nameController.text);
                        CheckLoginAuthentication();

                      },
                    )),

                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(241, 123, 72 ,1),
                      child: Text('Are you a Cleaner?',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,)),
                      onPressed: () {
                 CheckProviderLoginAuthentication();
                        //print(nameController.text);
                      },
                    )),
              ],
            )));
  }

  void _navigateToNextScreen1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderChooseCountry()),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserChooseCountry()),
    );
  }
  void _navigateToHomeScreen(BuildContext context) {


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
    );
  }
  void _navigateToProviderHomeScreen(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseProfessionProvider()),
    );
  }

}