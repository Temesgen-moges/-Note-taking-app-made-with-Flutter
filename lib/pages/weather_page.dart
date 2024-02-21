import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_by_using_flutter/models/weather_model.dart';
import 'package:weather_app_by_using_flutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('1b5adfbcd5fe0288b5a161b9dac2ad00');
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    // To get the current city
    String cityName = await _weatherService.getCurrentCity();

    // Get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e); // Print the error for debugging purposes
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      backgroundColor: Colors.amber,
      body: ListView(
        
        children: [
          Center(
          
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // for the city name
                Text(_weather?.cityName ?? "loading city ..."),
                // to add some animation depending on the temperature from our assets file
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                // for the temperature
                Text('${_weather?.temperature.round()}C'),
                // for the weather conditions which are also used for the animation
                Text(_weather?.mainCondition ?? ""),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        
        child: Container(
          
          height: 50.0,
          child: Center(
            child: Text(
              'Developed by Temesgen Moges\nContact: temu1554@gmail.com\nPhone: +251985246737',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        color: Colors.blue, // Set the color of the bottom app bar
      ),
    );
  }
}
