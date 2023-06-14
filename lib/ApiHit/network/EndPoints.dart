import 'dart:convert';

// get reponse from API
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ApiHit/model/BeerListModel.dart';
import 'package:http/http.dart' as http;
// to check internet connection
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';




// Here we are using http package to fetch data from API
// We defined retrun type BeerListModel
String USER_API_KEY;
Map map_data;

Future<BeerListModel> getBeerListData(String url) async {
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
  final response = await http.get(url, headers: {
  'x-api-key': 'boguskey'});


  //json.decode used to decode response.body(string to map)
  map_data =json.decode(response.body);
  return BeerListModel.fromJson(json.decode(response.body)["data"]);
}

Future<BeerListModel> getCarListData(String url) async {
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
  final response = await http.get(url, headers: {
    'x-api-key': '5ff6e2867387d3.40964935'});

  //json.decode used to decode response.body(string to map)
  map_data =json.decode(response.body);
  return BeerListModel.fromJson(json.decode(response.body)["data"]);
}


// method defined to check internet connectivity
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
