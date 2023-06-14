import 'dart:async';
import 'dart:io';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/login/User_Email_Login.dart';
import 'package:click_a_clean/UserEnd/login/enter_password.dart';
import 'package:click_a_clean/UserEnd/login/password_set.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  bool _btnEnabled = false;
  bool _isVisible = true;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  SharedPreferences myPrefs;
  String Country_Code;
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  String accountStatus = "";
  TextEditingController EmailControler = new TextEditingController();

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
//  var platform = "Android";
//  if (Platform.isIOS) {
//  platform = "IOS";
//  }
//  else{
//  platform = "Android";
//  }
  void getData() async{
    myPrefs = await SharedPreferences.getInstance();
    print("======print_token_store_prefrence==="+myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL));
    Country_Code = myPrefs.getString(STORE_PREFS.USER_COUNTRY_CODE);
    if(Country_Code == null){
      Country_Code = "+91";
    }
    EmailControler.text = Country_Code != null ? Country_Code.toString(): "";

  }
  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  String phoneNo = "Your number here";
  String smsCode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();

  }
  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello========= ' + mCurrentUser.uid.toString());
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
  }
  Future POST_CHECK_PHONE(String phone) async {

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_PHONE_NUMBER_CHECK_URL,
          headers: {"x-api-key": 'boguskey'
          },

          body: {
            'phone': phone,
          }
      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price_ListResponse status: ${response.statusCode}");
        print("pricel_ListResponse body: ${response.body}");

        var jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            myPrefs.setString(STORE_PREFS.USER_ID_PHONE_NUMBER_GLOBAL,phone);
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EnterPassword()),
            );

          }

          else {

            verifyPhone(phone);

          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }

  Future POST_SIGNUP_API(String phone) async {

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_PHONE_SINGUP_URL,
          headers: {"x-api-key": 'boguskey'
          },

          body: {
            'phone': phone,
          }
      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price_ListResponse status: ${response.statusCode}");
        print("pricel_ListResponse body: ${response.body}");

        var jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,jsonData["data"][0]["id"].toString());
            myPrefs.setString(STORE_PREFS.USER_API_KEY,jsonData["data"][0]["apiKey"].toString());
            Fluttertoast.showToast(msg: "Sign Up Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1
            );

            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SetPassword()),
            );

          }

          else {

            verifyPhone(phone);

          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }


  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    firebaseAuth.currentUser().then((user){
      if(user !=null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
        );
      }else{
        //verifyPhone();
      }
    });
    this.setState(() {
      isLoading = false;
    });

  }
  Future<void> verifyPhone(String phone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieval=(String verId){
      this.verificationId=verId;
    };

    final PhoneCodeSent smsCodeSent=(String verId, [int forceCodeResend]){
      this.verificationId=verId;
      smsCodeDialog(context,phone).then((value){
        print("Signed in");
      });
    };

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) {
      print("verified");
    };

    final PhoneVerificationFailed verfifailed=(AuthException exception){
      print("${exception.message}");
      Fluttertoast.showToast(msg: exception.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        codeAutoRetrievalTimeout: autoRetrieval,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verificationCompleted,
        verificationFailed: verfifailed
    );
  }

  Future<bool> smsCodeDialog(BuildContext context,String phone){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter Sms Code'),
            content: Container(margin:EdgeInsets.only(left: 10,right: 10),child:TextField(
              keyboardType: TextInputType.number,
              onChanged: (value){
                this.smsCode=value;
              },
            )),
            contentPadding: const EdgeInsets.all(10.0),
            actions: <Widget>[
              new Container(
                margin:EdgeInsets.only(right:10),
                  child:FlatButton(
                child: Text("Done"),
                textColor: Colors.white,
                color: Color.fromRGBO(125, 121, 204, 1),
                onPressed: (){

                  Navigator.of(context).pop();
                      signIn(phone);

                },
              ))
            ],
          );
        }
    );
  }

  signIn(String phone)async{
    AuthCredential credential= PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode
    );
    await  firebaseAuth.signInWithCredential(credential).then((user){


      POST_SIGNUP_API(phone);
      print('signed in with phone number successful: user -> $user');

    }).catchError((onError){
      print(onError);
      if(onError.code == 'ERROR_INVALID_VERIFICATION_CODE'){
        Fluttertoast.showToast(msg: "Please Enter Valid Code",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1
        );
      }
      else{
      Fluttertoast.showToast(msg: onError.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1
      );
    }}
      );
  }


  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    String phone_number = phone;
    _auth.verifyPhoneNumber(

        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          //Navigator.of(context).pop();

//          AuthResult result = await _auth.signInWithCredential(credential);
//
//          FirebaseUser user = result.user;
//
//          if(user != null){
////            Navigator.push(context, MaterialPageRoute(
////                builder: (context) => HomeScreen_Fragment(user: user,)
////            ));
//          }else{
//            print("Error");
//          }

          //This callback would gets called when verification is done automatically
        },
        verificationFailed: (AuthException exception){
          print("==========come in this==="+exception.message.toString());
          Fluttertoast.showToast(msg: exception.message.toString());
//          Fluttertoast.showToast(
//              msg: exception.message.toString(),
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.CENTER,
//              timeInSecForIos: 1
//          );
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),

                    ],
                  ),

                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Color.fromRGBO(125, 121, 204, 1),
                      onPressed: () async{
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                        try{
                        AuthResult result = await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if(user != null){

                          // ==============================Api Work ==========================================


                          var client = new http.Client();
                          try{
                            var response = await client.post(
                                APPURLS_USER.POST_USER_PHONE_SINGUP_URL,

                                headers: {"x-api-key" : "boguskey"},
                                body : {
                                  'phone': EmailControler.text,
                                }

                            );


                            if(response.statusCode == 200 ){
                              //enter your code

                              print("Response status: ${response.statusCode}");
                              print("Response body: ${response.body}");


                              final jsonData = json.decode(response.body);
                              if(jsonData["status"] == "true"){

                                myPrefs = await SharedPreferences.getInstance();
                                myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,jsonData["data"][0]["id"].toString());
                                myPrefs.setString(STORE_PREFS.USER_API_KEY,jsonData["data"][0]["apiKey"].toString());


                                var client = new http.Client();
                                try {
                                  var response = await client.post(
                                      APPURLS_USER.POST_USER_PHONE_LOGIN_URL,
                                      headers: {"x-api-key": "boguskey",

                                      },
                                      body: {
                                        'phone': EmailControler.text,
                                        "device_token": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                                        "device_type": "Android"
                                      }

                                  );

                                  if (response.statusCode == 200 ) {
                                    //enter your code

                                    print("Response status: ${response.statusCode}");
                                    print("Response body: ${response.body}");


                                    final jsonData = json.decode(response.body);
                                    if (jsonData["status"] == true) {
                                      Fluttertoast.showToast(
                                          msg: "Login Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                      );
                                      print("JSONResponse : ${jsonData["data"][0]["email"]}");
                                      SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                      myPrefs.setString(STORE_PREFS.USER_API_KEY,jsonData["data"][0]["apiKey"].toString());
                                      myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,jsonData["data"][0]["id"].toString());

                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));
                                    }

                                    else {

                                    }
                                  }
                                } on Exception catch (err) {
                                  print("Error : $err");
                                }



                              }

                              else{


                                var client = new http.Client();
                                try {
                                  var response = await client.post(
                                      APPURLS_USER.POST_USER_PHONE_LOGIN_URL,
                                      headers: {"x-api-key": "boguskey" ,

                                      },
                                      body: {
                                        'phone': EmailControler.text,
                                        "device_token": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                                        "device_type": "Android"
                                      }

                                  );

                                  if (response.statusCode == 200 ) {
                                    //enter your code

                                    print("Response status: ${response.statusCode}");
                                    print("Response body: ${response.body}");


                                    final jsonData = json.decode(response.body);
                                    if (jsonData["status"] == true) {
                                      Fluttertoast.showToast(
                                          msg: "Login Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                      );
                                      print("JSONResponse : ${jsonData["data"][0]["email"]}");
                                      SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                      myPrefs.setString(STORE_PREFS.USER_API_KEY,jsonData["data"][0]["apiKey"].toString());
                                      myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,jsonData["data"][0]["id"].toString());

                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));
                                    }

                                    else {

                                    }
                                  }
                                } on Exception catch (err) {
                                  print("Error : $err");
                                }


                              }


                            }
                          } on Exception catch (err){
                            print("Error : $err");
                          }


                          // ==============================End Api Work ======================================

                        }else{

                          print("Please Enter Verification Code");
                        }
                        }
                        catch (error) {

                         Fluttertoast.showToast(msg: error.toString());


                        }
                      },
                    ),
                    FlatButton (child: Text("Cancel"),
                      textColor: Colors.white,
                      color:  Color.fromRGBO(125, 121, 204, 1),
                    onPressed: (){
                      Navigator.of(context).pop();
                    //  loginUser1(phone_number, context);
                   },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }
  Future<bool> loginUser1(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          //Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
//            Navigator.push(context, MaterialPageRoute(
//                builder: (context) => HomeScreen_Fragment(user: user,)
//            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done automatically
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          Fluttertoast.showToast(msg: "Otp sent successfully");
        },
        codeAutoRetrievalTimeout: null
    );
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(

        body:  Column(
            children: <Widget>[

                Container(
                  color: Color.fromRGBO(125, 121, 204, 1),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                                  text: 'Login/Create Account \n',
                                  style: TextStyle(color: Colors.white,fontSize: 20.0 ), /*defining default style is optional */
                                  children: <TextSpan>[

                                    TextSpan(
                                        text: 'To get personalised experience', style: TextStyle(color: Colors.white,fontSize: 18.0)),

                                  ],
                                ),
                              ),

                             )),
                    ],

                  ),
                ),
              Container(
                padding: EdgeInsets.fromLTRB(20,30,20,0),

                child:

                TextFormField(

                    controller: EmailControler,
                    keyboardType: TextInputType.phone,

                    decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        labelText: "Enter mobile number",

                        suffixIcon: IconButton(
                            icon: Image(image: AssetImage("assets/images/next_icon.png"),height: 40,width: 80),
                            onPressed: () async {

                              validateMobile(EmailControler.text);
                            }

                        )
                    )),

              ),

              Padding(
                padding:EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                 child:FlatButton(
                   onPressed: (){
                     _navigateToNextScreen(context);
                   },
                 child: Text("Login with email",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,fontSize: 12.5)),),
              ),
                SizedBox(height: 5),
                Container(
                    padding:EdgeInsets.fromLTRB(10, 0, 10, 0) ,
                    child: Column(
                      children: <Widget>[
                        Center(

                        child: RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Your personal details are secure with us.Read our',
                            style: TextStyle(color: Color.fromRGBO(169, 189, 212, 1),fontSize: 12.5 ), /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Privacy', style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(241, 123, 72 ,1),fontSize: 12.5)),
                              TextSpan(
                                  text: ' Policy',
                                  style: TextStyle(color: Color.fromRGBO(241, 123, 72 ,1),fontSize: 12.5,fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' to know more.By Proceeding further you agree to our\n',
                                  style: TextStyle(color: Color.fromRGBO(169, 189, 212, 1), fontSize: 12.5)),
                              TextSpan(
                                  text: 'Terms and Conditions ',
                                  style: TextStyle(color: Color.fromRGBO(241, 123, 72 ,1), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),),

                        FlatButton(
                          textColor: Colors.grey,
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],)
            );
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 2 || value.length == 3 ||  value.length == 4 || value.length == 0) {
      Fluttertoast.showToast(msg: "Please enter phone number");
      return 'Please enter mobile number';
    }
    else if (value.length == 5 || value.length == 6 || value.length == 7 ||value.length == 8|| value.length == 10) {
      Fluttertoast.showToast(msg: "Please enter valid phone number");
      return 'Please enter valid mobile number';
    }

    else{
      POST_CHECK_PHONE(value);
    }
    return null;
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginEmailScreen()),
    );
  }
  void _navigateToNextScreen1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen_Fragment()),
    );
  }
}
