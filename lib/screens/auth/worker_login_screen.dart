import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/worker_auth_provider.dart';

import '../home/worker_home_screen.dart';

class WorkerLoginScreen extends StatefulWidget {
  const WorkerLoginScreen({super.key});

  @override
  State<WorkerLoginScreen> createState() => _WorkerLoginScreenState();
}

class _WorkerLoginScreenState extends State<WorkerLoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkerAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6FE7DD),

        title: const Text("Worker Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 50),

            TextField(
              controller: phoneController,

              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                bool success = await provider.loginWorker(phoneController.text);

                if (success) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (_) => const WorkerHomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Login Failed")));
                }
              },

              child: provider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
