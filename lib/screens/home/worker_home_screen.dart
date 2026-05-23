import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/socket_service.dart';

import '../../services/booking_service.dart';

import '../../services/location_service.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  final SocketService socketService = SocketService();

  final BookingService bookingService = BookingService();

  final LocationService locationService = LocationService();

  List<Map<String, dynamic>> bookings = [];

  bool isOnline = false;

  Timer? locationTimer;

  @override
  void initState() {
    super.initState();

    listenBookings();
  }

  void startLiveLocation() {
    locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await locationService.updateLocation(1);
    });
  }

  void stopLiveLocation() {
    locationTimer?.cancel();
  }

  void listenBookings() {
    socketService.bookingStream.listen((data) {
      if (data["type"] == "new_booking") {
        setState(() {
          bookings.insert(0, data);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("New Booking: ${data["service_type"]}")),
        );
      }
    });
  }

  Future<void> acceptBooking(int bookingId) async {
    bool success = await bookingService.acceptBooking(bookingId);

    if (success) {
      setState(() {
        bookings.removeWhere((booking) => booking["booking_id"] == bookingId);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Booking Accepted")));
    }
  }

  Future<void> rejectBooking(int bookingId) async {
    bool success = await bookingService.rejectBooking(bookingId);

    if (success) {
      setState(() {
        bookings.removeWhere((booking) => booking["booking_id"] == bookingId);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Booking Rejected")));
    }
  }

  @override
  void dispose() {
    stopLiveLocation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6FE7DD),

        title: const Text("PA Worker"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),

                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text("Status"),

                      const SizedBox(height: 5),

                      Text(
                        isOnline ? "ONLINE" : "OFFLINE",

                        style: TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                          color: isOnline ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  Switch(
                    value: isOnline,

                    onChanged: (value) async {
                      setState(() {
                        isOnline = value;
                      });

                      if (isOnline) {
                        startLiveLocation();
                      } else {
                        stopLiveLocation();
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: bookings.isEmpty
                  ? const Center(child: Text("No Live Bookings"))
                  : ListView.builder(
                      itemCount: bookings.length,

                      itemBuilder: (context, index) {
                        final booking = bookings[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 20),

                          child: Padding(
                            padding: const EdgeInsets.all(20),

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

                                Text("Status: ${booking["status"]}"),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),

                                        onPressed: () {
                                          acceptBooking(booking["booking_id"]);
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
                                          rejectBooking(booking["booking_id"]);
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
          ],
        ),
      ),
    );
  }
}
