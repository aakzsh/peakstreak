import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setNewChallenge(data)async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isChallengeActive", true);
  await prefs.setBool("iscompleted", false);
  await prefs.setInt("totalDays", int.parse(data["challengeDays"]));
  await prefs.setString("challengeName", data["challengeName"]);
  await prefs.setStringList("challenges", data["challengeArray"]);
  return true;
}