import 'package:shared_preferences/shared_preferences.dart';

Future<String> getChallengeName()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("challengeName")??"false";
}