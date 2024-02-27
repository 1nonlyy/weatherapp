import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: 'd67772ebbb62b83d529066db1a932b23');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await  _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e){
      print(e);
    }

  }

  String getweatheranimation(String? maincondition) {
    if(maincondition == null) return 'assets/sunny.json';
    switch (maincondition.toLowerCase()) {
      case 'fog': 
        return 'assets/cloudy.json';
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'snowy':
        return 'assets/snowy.json';
      default:
        return 'assets/cloudy.json';
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..."),

            Lottie.asset(getweatheranimation(_weather?.mainCondition)),

            Text("${_weather?.temperature.round()} °C"),
            const SizedBox(height: 15,),
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}