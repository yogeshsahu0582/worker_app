import 'package:flutter/material.dart';

import '../models/booking_model.dart';

import '../services/booking_service.dart';

class WorkerBookingProvider extends ChangeNotifier {
  final BookingService bookingService = BookingService();

  List<BookingModel> bookings = [];

  bool isLoading = false;

  Future<void> loadBookings() async {
    isLoading = true;

    notifyListeners();

    try {
      bookings = await bookingService.getPendingBookings();
    } catch (e) {
      bookings = [];
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> acceptBooking(int bookingId) async {
    bool success = await bookingService.acceptBooking(bookingId);

    if (success) {
      await loadBookings();
    }
  }

  Future<void> rejectBooking(int bookingId) async {
    bool success = await bookingService.rejectBooking(bookingId);

    if (success) {
      await loadBookings();
    }
  }
}
