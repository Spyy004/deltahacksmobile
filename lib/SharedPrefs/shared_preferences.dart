import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  Future<String?>getToken({required String key})async
  {
    final prefs = await SharedPreferences.getInstance();
    final getkey = '$key';
    final value = prefs.getString(getkey)?? null;
    print("THIS IS TOKEN IN SPREF");
    print(value);
    return value;
  }
  deleteLocalKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final finalKey = '$key';
    prefs.remove(finalKey);
    prefs.clear();
  }
}