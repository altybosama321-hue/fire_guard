import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_guard/theme/colors.dart';
import 'package:fire_guard/screens/login_screen.dart';

class DeviceStatusScreen extends StatelessWidget {
  const DeviceStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userEmail = currentUser?.email ?? 'Admin User (Offline Mode)';

    Future<void> logout() async {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        debugPrint('Logout error: $e');
      }
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          title: const Text(
            'Device Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const DeviceItem(
                icon: Icons.local_fire_department,
                title: 'Flame Sensor',
                status: 'Connected & Active',
              ),
              const DeviceItem(
                icon: Icons.air,
                title: 'Gas Sensor (MQ-2)',
                status: 'Connected & Active',
              ),
              const DeviceItem(
                icon: Icons.cloud,
                title: 'Smoke Sensor',
                status: 'Connected & Active',
              ),
              const DeviceItem(
                icon: Icons.water,
                title: 'Water Pump Relay',
                status: 'Ready / Standing By',
              ),
              const DeviceItem(
                icon: Icons.notifications_active,
                title: 'Alarm Bell Relay',
                status: 'Ready / Standing By',
              ),
              const DeviceItem(
                icon: Icons.memory,
                title: 'ESP32 Controller Module',
                status: 'Online',
              ),
              const DeviceItem(
                icon: Icons.cloud_done,
                title: 'Firebase Realtime Database',
                status: 'Synchronized',
              ),

              const SizedBox(height: 15),

              Text(
                'Live Connection: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFEFF2F5),
                      child: Icon(
                        Icons.person,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Logged in as',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            userEmail,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;

  const DeviceItem({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: darkBlue,
            size: 24,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              color: green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 7),
          const Icon(
            Icons.circle,
            color: green,
            size: 9,
          ),
        ],
      ),
    );
  }
}
