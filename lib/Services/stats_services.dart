import 'dart:convert';

import 'package:covid_tracker/Services/Utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../Model/world_stats_model.dart';

class StatsServices {
  //World Stats
  Future<WorldStatsModel> getWorldStats() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatsUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error!!!');
    }
  }

  //Countries Stats
  Future<List<dynamic>> getCountriesStats() async {
    final response = await http.get(Uri.parse(AppUrls.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error!!!');
    }
  }
}
