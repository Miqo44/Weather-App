import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey = "87342d200ce1d16590ca40f85dff644d"; // 🔥 Вставь свой API ключ OpenWeather

  /// 🔹 Получает текущие координаты пользователя
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверяем, включена ли служба геолокации
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("❌ Службы геолокации выключены");
      return null;
    }

    // Проверяем разрешения
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        debugPrint("❌ Доступ к геолокации запрещен навсегда");
        return null;
      }
    }

    // Получаем текущее местоположение
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint("📍 Координаты: ${position.latitude}, ${position.longitude}");
    return position;
  }


  /// 🔹 Получает погоду по координатам (широта, долгота)
  Future<Map<String, dynamic>?> fetchWeatherByLocation(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=ru";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
