import 'package:shared_preferences/shared_preferences.dart';

Future<String> getChallengeStart()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("startDay")??"ERROR";
}