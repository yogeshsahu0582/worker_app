import 'package:http/http.dart' as http;

class WorkerBookingService {
  static Future<bool> acceptBooking(int bookingId, String workerName) async {
    final response = await http.put(
      Uri.parse(
        "http://127.0.0.1:8000/booking/accept/$bookingId?worker_name=$workerName",
      ),
    );

    return response.statusCode == 200;
  }

  static Future<bool> rejectBooking(int bookingId) async {
    final response = await http.put(
      Uri.parse("http://127.0.0.1:8000/booking/reject/$bookingId"),
    );

    return response.statusCode == 200;
  }
}
