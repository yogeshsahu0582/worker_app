import 'package:dio/dio.dart';

import '../models/booking_model.dart';

import 'api_service.dart';

class BookingService {
  final ApiService apiService = ApiService();

  Future<List<BookingModel>> getPendingBookings() async {
    Response response = await apiService.dio.get("/bookings/pending");

    return (response.data as List)
        .map((booking) => BookingModel.fromJson(booking))
        .toList();
  }

  Future<bool> acceptBooking(int bookingId) async {
    try {
      await apiService.dio.put("/bookings/accept/$bookingId");

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectBooking(int bookingId) async {
    try {
      await apiService.dio.put("/bookings/reject/$bookingId");

      return true;
    } catch (e) {
      return false;
    }
  }
}
