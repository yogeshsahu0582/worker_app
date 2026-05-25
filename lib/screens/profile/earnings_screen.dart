import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Earnings")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.all(25),

              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.green,

                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Today's Earnings",

                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "₹2,450",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 36,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Jobs",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.work),

                    title: Text("Hospital Help"),

                    trailing: Text("₹450"),
                  ),

                  ListTile(
                    leading: Icon(Icons.work),

                    title: Text("Shopping Assistant"),

                    trailing: Text("₹350"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
