import 'dart:async';

import 'package:flutter/material.dart';

class ActiveJobScreen extends StatefulWidget {
  const ActiveJobScreen({
    super.key,
  });

  @override
  State<ActiveJobScreen> createState() => _ActiveJobScreenState();
}

class _ActiveJobScreenState extends State<ActiveJobScreen> {
  int seconds = 0;

  Timer? timer;

  bool started = false;

  void startTimer() {
    started = true;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          seconds++;
        });
      },
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  String formatTime() {
    int hrs = seconds ~/ 3600;

    int mins = (seconds % 3600) ~/ 60;

    int secs = seconds % 60;

    return "$hrs:$mins:$secs";
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Active Job",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Hospital Assistant",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text(
                        "Rahul Sharma",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Vijay Nagar, Indore",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    formatTime(),
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            if (!started)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    startTimer();
                  },
                  child: const Text(
                    "Start Work",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            if (started)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    stopTimer();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Job Completed",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Complete Work",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
