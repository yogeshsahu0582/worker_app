import 'package:http/http.dart' as http;

class LocationService {
  static Future<void> updateLocation({
    required int bookingId,

    required String workerName,

    required double latitude,

    required double longitude,
  }) async {
    await http.post(
      Uri.parse(
        "http://127.0.0.1:8000/location/update"
        "?booking_id=$bookingId"
        "&worker_name=$workerName"
        "&latitude=$latitude"
        "&longitude=$longitude",
      ),
    );
  }
}
