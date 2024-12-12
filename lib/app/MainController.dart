import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainController {
  static var apiUrl = ''.obs;

  static SharedPreferences? _prefs;


  //funtion for save boolean to SharedPreferences
  static Future<void> saveBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(key, value);
  }

  static Future<bool> loadSavedBool(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(key) ?? false;
  }


  static Future<void> saveUrl(String url) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString('apiUrl', url);
    apiUrl.value = url;
  }

  static Future<String> loadSavedUrl() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString('apiUrl') ?? '';
  }

 static Future<bool> checkApiConnection(String url) async {
    try {
      final response = await http.get(Uri.parse('$url/api/check-connection'));

      if (response.statusCode == 200) {
        await saveUrl(url);
        return true;
      } else {
        throw Exception('Invalid API response');
      }
    } catch (e) {
      return false;
    }
  }
}
