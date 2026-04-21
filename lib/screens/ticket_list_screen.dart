import 'package:flutter/material.dart';
import 'ticket_detail_screen.dart';

class TicketListScreen extends StatefulWidget {
  final String role;
  final bool isAssignMode;

  const TicketListScreen({
    super.key,
    required this.role,
    this.isAssignMode = false,
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
      "description": "User tidak bisa login ke sistem",
      "assignedTo": "-"
    },
    {
      "title": "Aplikasi crash",
      "status": "Progress",
      "date": "20 Apr 2026",
      "priority": "Medium",
      "description": "Aplikasi tiba-tiba crash",
      "assignedTo": "Budi"
    },
    {
      "title": "Tampilan tidak rapi",
      "status": "Done",
      "date": "19 Apr 2026",
      "priority": "Low",
      "description": "UI berantakan di halaman dashboard",
      "assignedTo": "-"
    },
  ];

  // FILTER UNTUK ASSIGN MODE
  List<Map<String, String>> get filteredTickets {
    if (widget.isAssignMode) {
      return tickets
          .where((t) => t["assignedTo"] == "-")
          .toList();
    }
    return tickets;
  }

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
        title: Text(
          widget.isAssignMode
              ? "Assign Tiket (ADMIN)"
              : widget.role == "admin"
                  ? "Manage Tiket (ADMIN)"
                  : "List Tiket",
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: filteredTickets.length,
        itemBuilder: (context, index) {
          final ticket = filteredTickets[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetailScreen(
                    ticket: ticket,
                    role: widget.role,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  final originalIndex = tickets.indexWhere(
                    (t) => t["title"] == ticket["title"],
                  );

                  if (originalIndex != -1) {
                    tickets[originalIndex] =
                        Map<String, String>.from(result);
                  }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
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

                  // DATE + PRIORITY
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

                  // STATUS BADGE
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

                  const SizedBox(height: 6),

                  // ASSIGNED INFO
                  Text(
                    "Assigned to: ${ticket["assignedTo"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // INFO TEXT
                  Text(
                    widget.isAssignMode
                        ? "Tap untuk assign tiket"
                        : "Tap untuk mengelola tiket",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
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