import 'package:click_a_clean/ProviderEnd/AccountSetup/Authentication/ProviderLogin.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';
import 'ApiHit/Constants/constants.dart';
import 'ApiHit/MyHomePage.dart';
import 'FirebaseIntegration/PhoneNumberFirebaseLogin/LoginScreenPhone.dart';
import 'PayPalIntegration/makePayment.dart';
import 'ProviderEnd/AccountSetup/Home/ChooseProfessionProvider.dart';
import 'UserEnd/NotificationHistory/UserNotificationHistory.dart';
import 'UserEnd/login/login_screen.dart';
import 'UserEnd/menu_fragment/booking_history/BookingTimeDomestic.dart';
import 'UserEnd/walk_through/choose_user.dart';
import 'UserEnd/walk_through/data.dart';
import 'demo_profile.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen()
  ));
}

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  SharedPreferences myPrefs;
  String USER_API_KEY,PROVIDR_USER_API_KEY;
    @override
    void initState() {
    super.initState();
    CheckLoginAuthentication();
    CheckLoginAuthenticationProvider();

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _saveDeviceToken();
    }
  _saveDeviceToken() async {
    // Get the current user

    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();
     myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(STORE_PREFS.FCM_TOKEN_GLOBAL,fcmToken);
    print("======fcm_token===="+fcmToken.toString());
  }
    void CheckLoginAuthentication() async{
      myPrefs = await SharedPreferences.getInstance();
  USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
  if(USER_API_KEY == null){
    loadData();
  }
  else{
    SecondloadData();
  }

}
  void CheckLoginAuthenticationProvider() async{
    myPrefs = await SharedPreferences.getInstance();
    PROVIDR_USER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);
    if(PROVIDR_USER_API_KEY == null){
      loadData();
    }
    else{
      ThirdloadData();
    }

  }
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  Future<Timer> SecondloadData() async {
    return new Timer(Duration(seconds: 0), SecondonDoneLoading);
  }

  SecondonDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));
  }
  Future<Timer> ThirdloadData() async {
    return new Timer(Duration(seconds: 0), ThirdloadLoading);
  }

  ThirdloadLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseProfessionProvider()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
         SvgPicture.asset("assets/images/main-logo.svg", alignment: Alignment.center,),

    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  Text first_name;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(

        color: isCurrentPage ? Color.fromRGBO(125, 121, 204, 1) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Color.fromRGBO(125, 121, 204, 1),

              ),
              Container(

                child: Row(

                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Color.fromRGBO(125, 121, 204, 1),

              ),
            ],
          ),
        ):
        InkWell(
          onTap: (){
            print("Continue_tapped");
            _navigateToNextScreen(context);

          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Color.fromRGBO(125, 121, 204, 1),
            alignment: Alignment.center,
            child: Text(
              "CONTINUE",
              style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Roboto'),

            ),

          ),
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chooseuser()),
    );
  }

}
class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile(
      {
    this.imagePath, this.title, this.desc
  }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
              color: Color.fromRGBO(241, 123, 72, 1),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 30
          ),),
          SizedBox(
            height: 5,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1), fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 18))
        ],
      ),
    );
  }
}