import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fire_guard/theme/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.ref('fire_guard');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: darkBlue,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: StreamBuilder<DatabaseEvent>(
          stream: dbRef.onValue,
          builder: (context, snapshot) {
            bool flameDetected = false;
            int gasLevel = 12;
            bool smokeDetected = false;
            bool pumpActive = false;
            bool alarmActive = false;
            bool isAutoMode = true;

            if (snapshot.hasError) {
              debugPrint('Firebase Database Error: ${snapshot.error}');
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.snapshot.value != null) {
              final rawValue = snapshot.data!.snapshot.value;
              if (rawValue is Map) {
                final data = rawValue.map(
                  (key, value) => MapEntry(key.toString(), value),
                );

                flameDetected = data['flame_detected'] == true || data['flame_detected'] == 1;
                gasLevel = int.tryParse(data['gas_level']?.toString() ?? '') ?? 12;
                smokeDetected = data['smoke_detected'] == true || data['smoke_detected'] == 1;
                pumpActive = data['pump_active'] == true || data['pump_active'] == 1;
                alarmActive = data['alarm_active'] == true || data['alarm_active'] == 1;
                isAutoMode = data['is_auto_mode'] == true || data['is_auto_mode'] == 1 || data['is_auto_mode'] == null;
              }
            }

            final bool hasDanger = flameDetected || smokeDetected || gasLevel > 300;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: hasDanger ? red : green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          hasDanger ? Icons.warning_amber_rounded : Icons.shield_outlined,
                          color: Colors.white,
                          size: 42,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasDanger ? 'EMERGENCY ALARM' : 'SYSTEM NORMAL',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hasDanger
                                    ? 'Fire or Gas hazard detected! Suppression active.'
                                    : 'All sensors reading safe levels (${isAutoMode ? "Auto Mode" : "Manual Mode"})',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                    children: [
                      SensorCard(
                        title: 'Flame Sensor',
                        value: flameDetected ? 'DANGER!' : 'SAFE',
                        icon: Icons.local_fire_department,
                        color: flameDetected ? red : green,
                      ),
                      SensorCard(
                        title: 'Gas Sensor',
                        value: '$gasLevel ppm',
                        icon: Icons.air,
                        color: gasLevel > 300 ? red : green,
                      ),
                      SensorCard(
                        title: 'Smoke Sensor',
                        value: smokeDetected ? 'SMOKE DETECTED' : 'CLEAR',
                        icon: Icons.cloud,
                        color: smokeDetected ? red : green,
                      ),
                      SensorCard(
                        title: 'Water Pump',
                        value: pumpActive ? 'PUMPING WATER 💧' : 'STANDBY',
                        icon: Icons.water,
                        color: pumpActive ? Colors.blue : Colors.grey,
                      ),
                      SensorCard(
                        title: 'Alarm Bell',
                        value: alarmActive ? 'ALARMING 🔔' : 'OFF',
                        icon: alarmActive ? Icons.notifications_active : Icons.notifications_off,
                        color: alarmActive ? red : Colors.grey,
                      ),
                      SensorCard(
                        title: 'System Mode',
                        value: isAutoMode ? 'AUTOMATIC' : 'MANUAL',
                        icon: Icons.settings_suggest,
                        color: darkBlue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Realtime Sync: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 27,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
