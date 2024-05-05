import 'package:shared_preferences/shared_preferences.dart';

Future<int> getTotalDays()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getInt("totalDays")??0;
}