import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../services/worker_booking_service.dart';

class LiveBookingsScreen extends StatefulWidget {
  const LiveBookingsScreen({super.key});

  @override
  State<LiveBookingsScreen> createState() => _LiveBookingsScreenState();
}

class _LiveBookingsScreenState extends State<LiveBookingsScreen> {
  List bookings = [];

  bool isOnline = true;

  @override
  void initState() {
    super.initState();

    loadBookings();
  }

  Future<void> loadBookings() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/booking/pending"),
    );

    if (response.statusCode == 200) {
      setState(() {
        bookings = jsonDecode(response.body);
      });
    }
  }

  Future<void> acceptBooking(int bookingId) async {
    bool success = await WorkerBookingService.acceptBooking(
      bookingId,

      "Rohit Worker",
    );

    if (success) {
      loadBookings();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Booking Accepted")));
    }
  }

  Future<void> rejectBooking(int bookingId) async {
    bool success = await WorkerBookingService.rejectBooking(bookingId);

    if (success) {
      loadBookings();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Booking Rejected")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Bookings"),

        actions: [
          Row(
            children: [
              const Text("Online"),

              Switch(
                value: isOnline,

                onChanged: (value) {
                  setState(() {
                    isOnline = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),

      body: bookings.isEmpty
          ? const Center(child: Text("No Live Bookings"))
          : RefreshIndicator(
              onRefresh: loadBookings,

              child: ListView.builder(
                itemCount: bookings.length,

                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  return Card(
                    margin: const EdgeInsets.all(12),

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            booking["service_type"],

                            style: const TextStyle(
                              fontSize: 20,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(booking["description"]),

                          const SizedBox(height: 5),

                          Text("📍 ${booking["location"]}"),

                          const SizedBox(height: 5),

                          Text("⏰ ${booking["duration"]}"),

                          const SizedBox(height: 5),

                          Text("₹ ${booking["price"]}"),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),

                                  onPressed: () {
                                    acceptBooking(booking["id"]);
                                  },

                                  child: const Text("Accept"),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),

                                  onPressed: () {
                                    rejectBooking(booking["id"]);
                                  },

                                  child: const Text("Reject"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
