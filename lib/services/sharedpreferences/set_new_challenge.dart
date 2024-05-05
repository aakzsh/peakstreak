import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setNewChallenge(data)async{
  var currentDate = DateTime.now();
  var prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isChallengeActive", true);
  await prefs.setBool("iscompleted", false);
  await prefs.setInt("totalDays", int.parse(data["challengeDays"]));
  await prefs.setString("challengeName", data["challengeName"]);
  await prefs.setStringList("challenges", data["challengeArray"]);
  await prefs.setStringList("challengeProgress", []);
  await prefs.setString("startDay", currentDate.toString());
  return true;
}