import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/worker_booking_provider.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  bool isOnline = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadBookings();

      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        loadBookings();
      });
    });
  }

  void loadBookings() {
    Provider.of<WorkerBookingProvider>(context, listen: false).loadBookings();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkerBookingProvider>(context);

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

                    onChanged: (value) {
                      setState(() {
                        isOnline = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.bookings.isEmpty
                  ? const Center(child: Text("No Booking Requests"))
                  : ListView.builder(
                      itemCount: provider.bookings.length,

                      itemBuilder: (context, index) {
                        final booking = provider.bookings[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 20),

                          child: Padding(
                            padding: const EdgeInsets.all(20),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  booking.serviceType,

                                  style: const TextStyle(
                                    fontSize: 20,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text("Status: ${booking.status}"),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),

                                        onPressed: () async {
                                          await provider.acceptBooking(
                                            booking.id,
                                          );
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

                                        onPressed: () async {
                                          await provider.rejectBooking(
                                            booking.id,
                                          );
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
