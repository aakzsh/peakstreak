import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setChallengeProgress(data)async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.setStringList("challengeProgress", data);
  return true;
}