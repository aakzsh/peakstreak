import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getChallengeActive()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isChallengeActive")??false;
}