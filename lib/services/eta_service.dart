import 'dart:convert';

import 'package:http/http.dart' as http;

class ETAService {
  static Future<String> getETA({
    required double originLat,

    required double originLng,

    required double destLat,

    required double destLng,
  }) async {
    String apiKey = "YOUR_GOOGLE_MAP_API_KEY";

    final url =
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=$originLat,$originLng"
        "&destination=$destLat,$destLng"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    if (data["routes"].isNotEmpty) {
      return data["routes"][0]["legs"][0]["duration"]["text"];
    }

    return "0 min";
  }
}
