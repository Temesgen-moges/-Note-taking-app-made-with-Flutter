//usd to feach the data from the api

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_by_using_flutter/models/weather_model.dart';

class WeatherService{
  static const BASE_URL ='http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherService(this.apiKey);
  Future<Weather> getWeather(String cityName) async {
      final response = await http.get(Uri.parse('BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
      if (response.statusCode==200){
        return Weather.fromjson(jsonDecode(response.body));
      }
      else {
        throw Exception('faild to load weather to the data');
      }
  }

  Future<String>getCurrentCity() async {
    // get permition from the user to get the location of the user 

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission== LocationPermission.denied){
      permission= await Geolocator.requestPermission();
    }

    // fech the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

      //convertion the locater in to a list of placemaker objects

      List<Placemark> placemakers =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      // extract only the city name from the location

      String? city = placemakers[0].locality;
      return city ?? "";
  }
}