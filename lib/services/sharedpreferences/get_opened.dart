import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getOpened()async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isOpened")??false;
}