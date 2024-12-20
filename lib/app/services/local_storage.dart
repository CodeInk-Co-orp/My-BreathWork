import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeData(String name, {bool? sayName, String? language}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('say_name', sayName ?? true);
  preferences.setString('name', name);
  preferences.setString('lang', language ?? 'en');
}

Future<void> storeId(String id) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('breathwork_id', id);
}

Future<String?> fetchId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? breathworkId = preferences.getString('breathwork_id');
  return breathworkId;
}

Future<bool> isSet() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? sayName = preferences.getBool('say_name');
  String? name = preferences.getString('name');
  return sayName != null && name != null;
}

Future<String> replaceData(Map input) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? sayName = preferences.getBool('say_name');
  String? name = preferences.getString('name');
  String? lang = preferences.getString('lang');
  String output = input[lang ?? 'en'].replaceAll('[placeholder]', sayName != null ? name ?? '' : '');
  return output;
}