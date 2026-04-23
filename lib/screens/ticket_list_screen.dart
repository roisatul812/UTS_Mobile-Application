import 'package:flutter/material.dart';
import 'ticket_detail_screen.dart';

class TicketListScreen extends StatefulWidget {
  final String role;

  const TicketListScreen({
    super.key,
    required this.role,
  });

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
      "assignedTo": "-"
    },
    {
      "title": "Aplikasi crash",
      "status": "Progress",
      "date": "20 Apr 2026",
      "priority": "Medium",
      "assignedTo": "Budi"
    },
    {
      "title": "Tampilan tidak rapi",
      "status": "Done",
      "date": "19 Apr 2026",
      "priority": "Low",
      "assignedTo": "-"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Tiket"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TicketDetailScreen(
                    ticket: ticket,
                    role: widget.role,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket["title"]!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "${ticket["date"]} • ${ticket["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _statusBadge(ticket["status"]!),

                    const SizedBox(height: 8),

                    if (widget.role == "admin")
                      Text(
                        "Assigned to: ${ticket["assignedTo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),

                    const SizedBox(height: 6),

                    Text(
                      widget.role == "admin"
                          ? "Tap untuk mengelola tiket"
                          : "Tap untuk melihat detail",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bg;
    Color text;

    switch (status) {
      case "Open":
        bg = Colors.red.shade100;
        text = Colors.red;
        break;
      case "Progress":
        bg = Colors.orange.shade100;
        text = Colors.orange;
        break;
      case "Done":
        bg = Colors.green.shade100;
        text = Colors.green;
        break;
      default:
        bg = Colors.grey.shade200;
        text = Colors.grey;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}