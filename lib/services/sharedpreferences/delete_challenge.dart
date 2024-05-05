import 'package:shared_preferences/shared_preferences.dart';

Future<bool> deleteChallenge()async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isChallengeActive", false);
  await prefs.setBool("iscompleted", false);
  return true;
}