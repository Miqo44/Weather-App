import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather_utils.dart';
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
  bool isLoading = false;
  List<Map<String, dynamic>> forecastData = []; // Изменим на прогноз на 5 дней

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });

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

      final forecast = await weatherService.fetch5DayForecast(
        position.latitude,
        position.longitude,
      );
      if (forecast != null) {
        DateTime currentTime = DateTime.now();
        setState(() {
          forecastData =
              forecast.where((item) {
                DateTime forecastTime = DateTime.fromMillisecondsSinceEpoch(
                  item['dt'] * 1000,
                );
                return forecastTime.isAfter(currentTime);
              }).toList();
        });
      }
    } else {
      setState(() {
        location = "Geolocation is disabled";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(getBackgroundImage(weatherCondition), fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 36),
                Container(
                  decoration: BoxDecoration(
                    color: getContainerColor(weatherCondition),
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
                            color: getTextColor(weatherCondition),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              getWeatherIcon(weatherCondition),
                              size: 60,
                              color: getIconColor(weatherCondition),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "${temperature.toStringAsFixed(0)}°C",
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: getTextColor(weatherCondition),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          weatherCondition[0].toUpperCase() +
                              weatherCondition.substring(1),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(weatherCondition),
                          ),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(weatherCondition),
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(weatherCondition),
                          ),
                        ),
                        Text(
                          "Feels like ${feelsLike.toStringAsFixed(0)}°C",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(weatherCondition),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: isLoading ? null : fetchWeather,
                          child: const Text("Refresh"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            getContainerColor(
                              weatherCondition,
                            ).withValues(alpha: 0.5),
                          ],
                          center: Alignment.center,
                          radius: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            forecastData.isNotEmpty
                                ? List.generate((forecastData.length / 5).ceil(), (
                                  rowIndex,
                                ) {
                                  int startIndex = rowIndex * 5;
                                  int endIndex =
                                      (startIndex + 5) > forecastData.length
                                          ? forecastData.length
                                          : startIndex + 5;
                                  var rowData = forecastData.sublist(
                                    startIndex,
                                    endIndex,
                                  );

                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(rowData.length, (
                                          index,
                                        ) {
                                          var forecast = rowData[index];
                                          DateTime time =
                                              DateTime.fromMillisecondsSinceEpoch(
                                                forecast['dt'] * 1000,
                                              );
                                          double temp =
                                              forecast['main']['temp'];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  DateFormat(
                                                    'HH:mm',
                                                  ).format(time),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      getWeatherIcon(
                                                        forecast['weather'][0]['main'],
                                                      ),
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "${temp.toStringAsFixed(0)}°",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                      if (rowIndex !=
                                          (forecastData.length / 5).ceil() - 1)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(
                                            color: Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                })
                                : [
                                  Text(
                                    'Loading forecast...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
