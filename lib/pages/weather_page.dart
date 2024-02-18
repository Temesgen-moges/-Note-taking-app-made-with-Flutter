import 'package:flutter/material.dart';
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
      body: _weather != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('City: ${_weather!.cityName}'),
                // Text('Temperature: ${_weather!.temperature}°C'),
                Text('${_weather?.temperature.round()}C')
                
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
