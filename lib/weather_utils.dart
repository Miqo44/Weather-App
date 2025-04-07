import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

IconData getWeatherIcon(String condition) {
  switch (condition.toLowerCase()) {
    case "clear":
      return Icons.wb_sunny;
    case "clouds":
      return Icons.cloud;
    case "rain":
    case "drizzle":
      return CupertinoIcons.cloud_drizzle_fill;
    case "snow":
      return Icons.ac_unit;
    case "thunderstorm":
      return CupertinoIcons.cloud_bolt_fill;
    case "mist":
    case "fog":
    case "haze":
      return CupertinoIcons.cloud_fog_fill;
    case "smoke":
      return CupertinoIcons.smoke;
    case "dust":
    case "sand":
      return Icons.waves;
    case "ash":
      return Icons.cloud_circle;
    case "squall":
      return CupertinoIcons.wind;
    case "tornado":
      return Icons.tornado;
    default:
      return Icons.help_outline;
  }
}

String getBackgroundImage(String condition) {
  switch (condition.toLowerCase()) {
    case "clear":
      return "assets/images/sun.png";
    case "clouds":
      return "assets/images/cloud.png";
    case "rain":
    case "drizzle":
      return "assets/images/rain.png";
    case "thunderstorm":
      return "assets/images/storm.png";
    case "snow":
      return "assets/images/snow.png";
    case "mist":
    case "smoke":
    case "haze":
    case "fog":
      return "assets/images/fog.png";
    case "dust":
    case "sand":
      return "assets/images/dust.png";
    case "ash":
      return "assets/images/ash.png";
    case "squall":
    case "tornado":
      return "assets/images/wind.png";
    default:
      return "assets/images/default.jpg";
  }
}

Color getContainerColor(String condition) {
  switch (condition.toLowerCase()) {
    case "clear":
      return const Color.fromRGBO(250, 226, 189, 1);
    case "rain":
    case "drizzle":
      return const Color.fromRGBO(97, 82, 115, 1);
    case "clouds":
      return const Color.fromRGBO(90, 139, 171, 1);
    case "snow":
      return const Color.fromRGBO(153, 184, 204, 1);
    case "thunderstorm":
      return const Color.fromRGBO(56, 40, 81, 1);
    case "mist":
    case "fog":
    case "haze":
      return const Color.fromRGBO(192, 192, 192, 1);
    case "smoke":
      return const Color.fromRGBO(110, 110, 110, 1);
    case "dust":
    case "sand":
      return const Color.fromRGBO(210, 180, 140, 1);
    case "ash":
      return const Color.fromRGBO(120, 120, 120, 1);
    case "squall":
    case "tornado":
      return const Color.fromRGBO(100, 100, 150, 1);
    default:
      return Colors.amberAccent;
  }
}

Color getTextColor(String condition) {
  switch (condition.toLowerCase()) {
    case "clear":
      return const Color.fromRGBO(239, 170, 130, 1);
    case "rain":
    case "drizzle":
      return const Color.fromRGBO(194, 184, 255, 1);
    case "clouds":
      return const Color.fromRGBO(174, 213, 228, 1);
    case "snow":
      return const Color.fromRGBO(228, 241, 249, 1);
    case "thunderstorm":
      return const Color.fromRGBO(221, 183, 255, 1);
    case "mist":
    case "fog":
    case "haze":
      return const Color.fromRGBO(180, 180, 180, 1);
    case "smoke":
      return const Color.fromRGBO(200, 200, 200, 1);
    case "dust":
    case "sand":
      return const Color.fromRGBO(240, 220, 190, 1);
    case "ash":
      return const Color.fromRGBO(220, 220, 220, 1);
    case "squall":
    case "tornado":
      return const Color.fromRGBO(200, 210, 230, 1);
    default:
      return Colors.black;
  }
}

Color getIconColor(String condition) {
  switch (condition.toLowerCase()) {
    case "clear":
      return const Color.fromRGBO(239, 170, 130, 1);
    case "rain":
    case "drizzle":
      return const Color.fromRGBO(194, 184, 255, 1);
    case "clouds":
      return const Color.fromRGBO(174, 213, 228, 1);
    case "snow":
      return const Color.fromRGBO(228, 241, 249, 1);
    case "thunderstorm":
      return const Color.fromRGBO(180, 140, 255, 1);
    case "mist":
    case "fog":
    case "haze":
      return const Color.fromRGBO(160, 160, 160, 1);
    case "smoke":
      return const Color.fromRGBO(130, 130, 130, 1);
    case "dust":
    case "sand":
      return const Color.fromRGBO(230, 200, 150, 1);
    case "ash":
      return const Color.fromRGBO(170, 170, 170, 1);
    case "squall":
    case "tornado":
      return const Color.fromRGBO(180, 200, 220, 1);
    default:
      return Colors.grey;
  }
}
