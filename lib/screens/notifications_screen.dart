import 'package:flutter/material.dart';
import 'package:fire_guard/theme/colors.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final String date;
  final IconData icon;
  final Color color;
  final String category; // 'flame' | 'gas' | 'smoke' | 'pump' | 'bell'
  final String details;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.date,
    required this.icon,
    required this.color,
    required this.category,
    required this.details,
  });
}

const List<NotificationModel> kMockNotifications = [
  NotificationModel(
    id: 'n1',
    title: 'Flame Detected',
    message: 'Flame has been detected in Zone A!',
    time: '10:42 AM',
    date: 'Today',
    icon: Icons.local_fire_department,
    color: red,
    category: 'flame',
    details: 'A flame was detected in Zone A at 10:42 AM.',
  ),
  NotificationModel(
    id: 'n2',
    title: 'Gas Leak Warning',
    message: 'High gas concentration detected.',
    time: '09:15 AM',
    date: 'Today',
    icon: Icons.air,
    color: orange,
    category: 'gas',
    details: 'Gas sensor recorded elevated levels in the kitchen area.',
  ),
  NotificationModel(
    id: 'n3',
    title: 'Pump Started',
    message: 'Water pump has been activated.',
    time: '10:42 AM',
    date: 'Today',
    icon: Icons.water,
    color: Colors.blue,
    category: 'pump',
    details: 'The water pump was activated in response to a flame alert.',
  ),
  NotificationModel(
    id: 'n4',
    title: 'Bell Activated',
    message: 'The alarm bell is currently ringing.',
    time: '10:42 AM',
    date: 'Today',
    icon: Icons.notifications_active,
    color: red,
    category: 'bell',
    details: 'Audio alarm has been triggered across the building.',
  ),
  NotificationModel(
    id: 'n5',
    title: 'Smoke Detected',
    message: 'Smoke level above normal.',
    time: '08:30 AM',
    date: 'Yesterday',
    icon: Icons.cloud,
    color: Colors.grey,
    category: 'smoke',
    details: 'Smoke sensor (MQ-2) triggered a warning event.',
  ),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';

  static const List<Map<String, dynamic>> _filters = [
    {'label': 'All', 'category': 'all', 'icon': Icons.apps},
    {'label': 'Flame', 'category': 'flame', 'icon': Icons.local_fire_department},
    {'label': 'Gas', 'category': 'gas', 'icon': Icons.air},
    {'label': 'Smoke', 'category': 'smoke', 'icon': Icons.cloud},
    {'label': 'Pump', 'category': 'pump', 'icon': Icons.water},
    {'label': 'Bell', 'category': 'bell', 'icon': Icons.notifications_active},
  ];

  List<NotificationModel> get _filtered {
    if (_selectedFilter == 'All') {
      return kMockNotifications;
    }
    return kMockNotifications.where((n) {
      return n.category == _selectedFilter.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        appBar: AppBar(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          title: const Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Filter chips
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((f) {
                    final selected = _selectedFilter == f['label'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        avatar: Icon(
                          f['icon'] as IconData,
                          size: 15,
                          color: selected ? Colors.white : darkBlue,
                        ),
                        label: Text(
                          f['label'] as String,
                          style: TextStyle(
                            color: selected ? Colors.white : darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = f['label'] as String;
                          });
                        },
                        selectedColor: red,
                        backgroundColor: const Color(0xFFF0F2F5),
                        checkmarkColor: Colors.white,
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: selected ? red : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
              child: Row(
                children: [
                  Text(
                    '${items.length} alert${items.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_off,
                              size: 58, color: Colors.grey.shade300),
                          const SizedBox(height: 12),
                          Text(
                            'No notifications found',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _NotificationCard(notification: items[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 72,
              decoration: BoxDecoration(
                color: n.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: n.color.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(n.icon, color: n.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      n.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      n.message,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${n.date}  •  ${n.time}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
