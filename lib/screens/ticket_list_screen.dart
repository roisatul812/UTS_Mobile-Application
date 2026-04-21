import 'package:flutter/material.dart';
import 'ticket_detail_screen.dart';

class TicketListScreen extends StatefulWidget {
  final String role;

  const TicketListScreen({super.key, required this.role});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  List<Map<String, String>> tickets = [
    {
      "title": "Tidak bisa login",
      "status": "Open",
      "date": "21 Apr 2026",
      "priority": "High",
      "description": "User tidak bisa login ke sistem"
    },
    {
      "title": "Aplikasi crash",
      "status": "Progress",
      "date": "20 Apr 2026",
      "priority": "Medium",
      "description": "Aplikasi tiba-tiba crash"
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.red.shade300;
      case "Progress":
        return Colors.orange.shade300;
      case "Done":
        return Colors.green.shade300;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("List Tiket (${widget.role.toUpperCase()})"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TicketDetailScreen(
                    ticket: ticket,
                    role: widget.role,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  tickets[index] =
                      Map<String, String>.from(result);
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket["title"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${ticket["date"]} • ${ticket["priority"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: getStatusColor(
                              ticket["status"]!)
                          .withOpacity(
                              isDark ? 0.25 : 0.15),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      ticket["status"]!,
                      style: TextStyle(
                        color: getStatusColor(
                            ticket["status"]!),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}