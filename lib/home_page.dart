import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'weather_service.dart';

class WeatherBackground extends StatefulWidget {
  const WeatherBackground({super.key});

  @override
  WeatherBackgroundState createState() => WeatherBackgroundState();
}

class WeatherBackgroundState extends State<WeatherBackground> {
  final WeatherService weatherService = WeatherService();
  String weatherCondition = "clear";
  double temperature = 0.0;
  double feelsLike = 0.0;
  String location = "the location is determined...";
  String time = "";

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    Position? position = await weatherService.getCurrentLocation();
    if (position != null) {
      final data = await weatherService.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      if (data != null) {
        setState(() {
          weatherCondition = data["weather"][0]["main"].toLowerCase();
          temperature = data["main"]["temp"];
          feelsLike = data["main"]["feels_like"];
          location = data["name"];
          DateTime now = DateTime.now();
          time = DateFormat("dd MMM yyyy").format(now);
        });
      }
    } else {
      setState(() {
        location = "Geolocation is disabled";
      });
    }
  }

  String getBackgroundImage() {
    switch (weatherCondition) {
      case "clear":
        return "assets/images/sun.png";
      case "rain":
        return "assets/images/rain.png";
      case "clouds":
        return "assets/images/cloud.png";
      case "snow":
        return "assets/images/snow.png";
      default:
        return "assets/images/default.jpg";
    }
  }

  IconData getWeatherIcon() {
    switch (weatherCondition) {
      case "clear":
        return Icons.wb_sunny;
      case "rain":
        return Icons.beach_access;
      case "clouds":
        return Icons.cloud;
      case "snow":
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }

  Color getContainerColor() {
    switch (weatherCondition) {
      case "clear":
        return Color.fromRGBO(250, 226, 189, 1);
      case "rain":
        return Color.fromRGBO(97, 82, 115, 1);
      case "clouds":
        return Color.fromRGBO(90, 139, 171, 1);
      case "snow":
        return Color.fromRGBO(153, 184, 204, 1);
      default:
        return Colors.amberAccent;
    }
  }

  Color getTextColor() {
    switch (weatherCondition) {
      case "clear":
        return Color.fromRGBO(239, 170, 130, 1);
      case "rain":
        return Color.fromRGBO(194, 184, 255, 1);
      case "clouds":
        return Color.fromRGBO(174, 213, 228, 1);
      case "snow":
        return Color.fromRGBO(228, 241, 249, 1);
      default:
        return Colors.black;
    }
  }

  Color getIconColor() {
    switch (weatherCondition) {
      case "clear":
        return Color.fromRGBO(239, 170, 130, 1);
      case "rain":
        return Color.fromRGBO(194, 184, 255, 1);
      case "clouds":
        return Color.fromRGBO(174, 213, 228, 1);
      case "snow":
        return Color.fromRGBO(228, 241, 249, 1);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(getBackgroundImage(), fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: getContainerColor(),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(getWeatherIcon(), size: 60, color: getIconColor()),
                            const SizedBox(width: 20),
                            Text(
                              "${temperature.toStringAsFixed(1)}°C",
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: getTextColor(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          weatherCondition[0].toUpperCase() + weatherCondition.substring(1),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        Text(
                          "Feels like ${feelsLike.toStringAsFixed(1)}°C",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(onPressed: fetchWeather, child: const Text("Refresh")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
