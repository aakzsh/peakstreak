import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getChallengeTasks()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("challenges")??[];
}