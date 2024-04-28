import 'package:shared_preferences/shared_preferences.dart';

Future<void> setFirstTime()async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isOpened", true);
  await prefs.setBool("isChallengeActive", false);
  await prefs.setBool("iscompleted", false);
  await prefs.setInt("totalDays", 0);
  await prefs.setStringList("challenges", []);
  await prefs.setStringList("challengeData", []);
}