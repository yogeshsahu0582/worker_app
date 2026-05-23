import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class LiveBookingsScreen extends StatefulWidget {
  const LiveBookingsScreen({super.key});

  @override
  State<LiveBookingsScreen> createState() => _LiveBookingsScreenState();
}

class _LiveBookingsScreenState extends State<LiveBookingsScreen> {
  List bookings = [];

  @override
  void initState() {
    super.initState();

    loadBookings();
  }

  Future<void> loadBookings() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/booking/all"),
    );

    if (response.statusCode == 200) {
      setState(() {
        bookings = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Bookings")),

      body: ListView.builder(
        itemCount: bookings.length,

        itemBuilder: (context, index) {
          final booking = bookings[index];

          return Card(
            child: ListTile(
              title: Text(booking["service_type"]),

              subtitle: Text(booking["location"]),

              trailing: ElevatedButton(
                onPressed: () {},

                child: const Text("Accept"),
              ),
            ),
          );
        },
      ),
    );
  }
}
