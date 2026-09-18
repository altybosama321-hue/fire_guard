import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fire_guard/theme/colors.dart';

class ControlPanelScreen extends StatelessWidget {
  const ControlPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.ref('fire_guard');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          title: const Text(
            'Control Panel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<DatabaseEvent>(
          stream: dbRef.onValue,
          builder: (context, snapshot) {
            bool isAutoMode = true;
            bool pumpOn = false;
            bool alarmOn = false;

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
                isAutoMode = data['is_auto_mode'] == true || data['is_auto_mode'] == 1 || data['is_auto_mode'] == null;
                pumpOn = data['pump_active'] == true || data['pump_active'] == 1;
                alarmOn = data['alarm_active'] == true || data['alarm_active'] == 1;
              }
            }

            void setAutoMode(bool auto) {
              dbRef.update({'is_auto_mode': auto});
            }

            void togglePump(bool value) {
              dbRef.update({'pump_active': value});
            }

            void toggleAlarm(bool value) {
              dbRef.update({'alarm_active': value});
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Operating Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ModeButton(
                          title: 'Auto',
                          selected: isAutoMode,
                          onTap: () => setAutoMode(true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ModeButton(
                          title: 'Manual',
                          selected: !isAutoMode,
                          onTap: () => setAutoMode(false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  if (!isAutoMode) ...[
                    const Text(
                      'Manual Control Options',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ControlRow(
                      icon: Icons.water,
                      title: 'Water Pump',
                      value: pumpOn,
                      onChanged: togglePump,
                    ),
                    const SizedBox(height: 12),
                    ControlRow(
                      icon: Icons.notifications_active,
                      title: 'Alarm Bell',
                      value: alarmOn,
                      onChanged: toggleAlarm,
                    ),
                    const SizedBox(height: 25),
                  ],
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: darkBlue,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            isAutoMode
                                ? 'In Auto mode, the system automatically triggers pump & bell based on sensor thresholds.'
                                : 'In Manual mode, you have direct control over the pump and alarm switches.',
                            style: const TextStyle(
                              color: darkBlue,
                            ),
                          ),
                        ),
                      ],
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

class ModeButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const ModeButton({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: selected ? red : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected ? red : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ControlRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ControlRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
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
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: green,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
