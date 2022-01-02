import 'dart:convert';
import 'package:http/http.dart' as http;

var API_KEY = "";
Future getWeatherFromApi(String city) async {
  var response = await http.get(Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY"));
  var jsonData = jsonDecode(response.body);
  return jsonData;
}
