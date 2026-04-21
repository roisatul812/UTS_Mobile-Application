import 'package:flutter/material.dart';
import 'create_ticket_screen.dart';

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
    },
    {
      "title": "Aplikasi crash",
      "status": "Progress",
      "date": "20 Apr 2026",
      "priority": "Medium",
    },
  ];

  Future<void> goToCreateTicket() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateTicketScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        tickets.insert(0, Map<String, String>.from(result));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("List Tiket (${widget.role.toUpperCase()})"),
      ),

      floatingActionButton: widget.role == "user"
          ? FloatingActionButton(
              onPressed: goToCreateTicket,
              child: const Icon(Icons.add),
            )
          : null,

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];

          Color statusColor;
          Color bgColor;

          switch (ticket["status"]) {
            case "Open":
              statusColor = const Color(0xFFE57373);
              bgColor = isDark
                  ? const Color(0xFF3A1F1F)
                  : const Color(0xFFFDECEA);
              break;

            case "Progress":
              statusColor = const Color(0xFFFFC107);
              bgColor = isDark
                  ? const Color(0xFF3A3320)
                  : const Color(0xFFFFF8E1);
              break;

            case "Done":
              statusColor = const Color(0xFF81C784);
              bgColor = isDark
                  ? const Color(0xFF1F3324)
                  : const Color(0xFFE8F5E9);
              break;

            default:
              statusColor = Colors.grey;
              bgColor = isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 5),
                    Text(
                      "${ticket["date"]} • ${ticket["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ticket["status"]!,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                if (widget.role == "admin")
                  const Icon(Icons.edit),
              ],
            ),
          );
        },
      ),
    );
  }
}