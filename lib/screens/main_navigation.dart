import 'package:flutter/material.dart';
import 'package:fire_guard/theme/colors.dart';
import 'package:fire_guard/screens/dashboard_screen.dart';
import 'package:fire_guard/screens/control_panel_screen.dart';
import 'package:fire_guard/screens/notifications_screen.dart';
import 'package:fire_guard/screens/device_status_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardScreen(),
    ControlPanelScreen(),
    NotificationsScreen(),
    DeviceStatusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: red.withValues(alpha: 0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: red),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_remote_outlined),
            selectedIcon: Icon(Icons.settings_remote, color: red),
            label: 'Control',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications, color: red),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.devices_outlined),
            selectedIcon: Icon(Icons.devices, color: red),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}

