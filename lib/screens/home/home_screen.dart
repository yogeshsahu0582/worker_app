import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        selectedItemColor: Colors.amber,

        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: "Earning",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(color: Color(0xFFFFC107)),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(50),
                            ),

                            child: const Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey),

                                SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    "Current Location",

                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Column(
                          children: [
                            const Text(
                              "OFF DUTY",

                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Switch(
                              value: isOnline,

                              activeColor: Colors.green,

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

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                "YOGESH SAHU",

                                style: TextStyle(
                                  fontSize: 30,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Your Earning",

                                style: TextStyle(fontSize: 22),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "₹ 0.00",

                                style: TextStyle(
                                  fontSize: 40,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Image.network(
                          "https://cdn-icons-png.flaticon.com/512/3202/3202926.png",

                          height: 180,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),

                child: GridView.count(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisCount: 2,

                  crossAxisSpacing: 15,

                  mainAxisSpacing: 15,

                  childAspectRatio: 1.2,

                  children: [
                    buildCard("Total Work\nAccepted", "0"),

                    buildCard("Your\nRating", "0.00"),

                    buildCard("Today's Work\nAccepted", "0"),

                    buildCard("Today's\nEarning", "₹0.00"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.grey.shade300,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),

          Align(
            alignment: Alignment.bottomRight,

            child: Text(
              value,

              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
