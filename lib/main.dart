// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:weatherboop/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'api.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Weather Boop",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var weather;
  var humidity;
  var city;

  Future getWeather() async {
    var result = await getWeatherFromApi("Beirut");
    setState(() {
      temp = result["main"]["temp"];
      temp = temp.toInt();
      temp = temp - 273;
      weather = result["weather"][0]["main"];
      humidity = result["main"]["humidity"];
      city = result["name"];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF26745),
                  Color(0xFFF14345),
                ],
              ),
            ),
          ),
        ),
        city == null
            ? const Align(
                child: CircularProgressIndicator(),
                alignment: Alignment(0, 0),
                heightFactor: 5,
              )
            : Align(
                child: Text(
                  city,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    letterSpacing: 3,
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                alignment: const Alignment(0, 0),
                heightFactor: 5,
              ),
        Align(
          alignment: const Alignment(0, 0.45),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GlassMorphism(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 32),
                      temp == null
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  temp < 15
                                      ? FontAwesomeIcons.cloudRain
                                      : (temp < 25
                                          ? FontAwesomeIcons.cloud
                                          : (temp < 30
                                              ? FontAwesomeIcons.cloudSun
                                              : FontAwesomeIcons.sun)),
                                  size: 32,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  "$temp Cº",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 46,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 32),
                      humidity == null
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  humidity < 5
                                      ? FontAwesomeIcons.thermometerQuarter
                                      : (humidity < 20
                                          ? FontAwesomeIcons.thermometerHalf
                                          : (humidity < 30
                                              ? FontAwesomeIcons
                                                  .thermometerThreeQuarters
                                              : FontAwesomeIcons
                                                  .thermometerFull)),
                                  size: 32,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 18),
                                humidity == null
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "$humidity %",
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                              ],
                            ),
                      const SizedBox(height: 50),
                      weather == null
                          ? const CircularProgressIndicator()
                          : Text(
                              weather ?? const CircularProgressIndicator(),
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              start: 0.55,
              end: 0.25,
            ),
          ),
        ),
      ],
    );
  }
}
